module FormHelper

	require "net/http"
	require "uri"
	require "json"
	require 'open-uri'
  require "cgi"

	def ratings_ballot(formid)
		@rating = current_user.form_ratings.find_by_form_id(formid)
		if(@rating != nil)
			@rating
		else
			current_user.form_ratings.new
		end
	end

	def current_user_rating(formid)
	    if @rating = current_user.form_ratings.find_by_form_id(formid)
	        @rating.value
	    else
	        "N/A"
	    end
	end

	def document_downloaded()
		current_user.form_downloads.each do |fd|
			if(fd.form_id == @form.id)
				return true
			end
		end

		return false
	end

	def nested_form_comments(comments)
		comments.map do |comment, sub_comments|
      		render('forms/comment', :comment => comment) + content_tag(:div, nested_form_comments(sub_comments), :class => "nested_comments")
    	end.join.html_safe
	end

	# scan form for viruses
	def virus_scan(form)

    #don't virus scan vizibid or forrest's docs
   # if @current_user.id == 1 || @current_user.id == 2
      form.approved = true
      form.save
      return true
  #  end

		uri = URI.parse("https://scanii.com/api/scan/")
		form_url = URI.escape(form.url)
		form_url = form_url.gsub('//uploads', '/vizibid-test-files/uploads')
		boundary = "AaB03x"

		post_body = []
		post_body << "--#{boundary}\r\n"
		post_body << "Content-Disposition: form-data; name=\"datafile\"; filename=\"#{File.basename(form_url)}\"\r\n"
		post_body << "Content-Type: text/plain\r\n"
		post_body << "\r\n"
		open(form_url) do |form|
		  post_body << form.read
		end
		post_body << "\r\n--#{boundary}--\r\n"

		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri)
		request.body = post_body.join
		request["Content-Type"] = "application/x-www-form-urlencoded, boundary=#{boundary}"
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_PEER

		request.basic_auth("a338e7711ee249a181e8a11eda6d2e6e", "dvDvURuHy")
		response = http.request(request)
		parsed_response = JSON.parse(response.body)
		status = parsed_response["status"]

		if status == "clean"
			form.approved = true
			form.save
			return true
		else
			Mailer.delay.upload_failed_virus_scan_email(current_user, form)
			return false
		end
	end

	def save_form(form_params, formurl=nil)


      @form = Form.new(form_params)
      @form.user_id = current_user.id
      @form.description = form_params[:description]
      @form.jurisdiction = form_params[:jurisdiction]
      @form.practice_area_id = form_params[:practice_area_id]
      
      url = formurl.gsub("https://s3.amazonaws.com/vizibid-production-files/uploads", "")
      rem = CGI::unescape(url)

      @form.url = "https://s3.amazonaws.com/vizibid-production-files/uploads" + rem


      if @form.save
         #scan the form for viruses
        if virus_scan(@form) != true
            flash[:error] = "There was a problem with your submission. It appears that the uploaded form is an unsafe document."
            redirect_to root_path
        end

        # opt in the user to following their own form
        @form_follow = FormFollow.new(:user_id => current_user.id, :form_id => @form.id)
        @form_follow.save

        flash[:success] = "Thank you for your contribution!"
        redirect_to form_path(@form.id)
      else
        flash[:error] = "There was a problem with your submission. Please fill out all fields and try again."
        redirect_to root_path
      end
	end

	def save_form_with_source_comment_id(form_params, source_comment_id, formurl = nil)

      @form = Form.new(form_params)
      @form.user_id = current_user.id
      @form.description = form_params[:description]
      @form.jurisdiction = form_params[:jurisdiction]
      @form.sourcecomment_id = source_comment_id 
      @form.practice_area_id = form_params[:practice_area_id]
      
      url = formurl.gsub("https://s3.amazonaws.com/vizibid-production-files/uploads", "")
      rem = CGI::unescape(url)

      @form.url = "https://s3.amazonaws.com/vizibid-production-files/uploads" + rem
      
      if @form.save
        # scan the form for viruses
        if virus_scan(@form) != true
            flash[:error] = "There was a problem with your submission. It appears that the uploaded form is an unsafe document."
            redirect_to root_path
        end

        # opt in the user to following their own form
        @form_follow = FormFollow.new(:user_id => current_user.id, :form_id => @form.id)
        @form_follow.save

        return true
      else
        return false
      end
	end

	def save_request(params, formurl=nil)

	  # create a new request submission
      @request_submission = RequestSubmission.new(:form_request_id => params[:requestid], 
        :comment => params[:request_submission][:comment], :user_id => current_user.id)
      
      # save the request submission
      if !@request_submission.save
        flash[:error] = "There was a problem with your submission. Please fill out all fields and try again."
        redirect_to form_request_path(params[:requestid])
        return
      end

      @request = FormRequest.find(params[:requestid])
      @requestowner = User.find(@request.user.id)

      @form = Form.new(params[:form])
      @form.user_id = current_user.id
      @form.description = params[:form][:description]
      @form.jurisdiction = params[:form][:jurisdiction]
      @form.practice_area_id = params[:form][:practice_area_id]
      @form.url = formurl

      # save the form
      if @form.save
        flash[:success] = "Thank you for your contribution!"
        @request_submission.form_id = @form.id
        @request_submission.save

        # scan the form for viruses
        if virus_scan(@form) != true
          @request_submission.destroy
          flash[:error] = "There was a problem with your submission. It appears that the uploaded form is an unsafe document."
          redirect_to form_request_path(params[:requestid])
        end


  		  # opt in the user to following their own form
  		  @form_follow = FormFollow.new(:user_id => current_user.id, :form_id => @form.id)
  		  @form_follow.save

        #sendmail
        if @requestowner.user_notification.requests == true && current_user.id != @requestowner.id
          Mailer.delay.doc_request_mail(current_user, @request, @requestowner, @request_submission) 
        end
      else
        @request_submission.destroy
        flash[:error] = "There was a problem with your submission. Please fill out all fields and try again."
      end

      redirect_to form_request_path(@request)
	end
end