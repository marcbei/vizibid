module FormHelper

	require "net/http"
	require "uri"
	require "json"
	require 'open-uri'

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

		uri = URI.parse("https://scanii.com/api/scan/")
		form_url = form.form.url
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

		## enable this do do virus scan
		#request.basic_auth("d50cff87d2414c70b312461bac787dfd", "sYMTxSJP3")
		#response = http.request(request)
		#parsed_response = JSON.parse(response.body)
		status = "clean" #parsed_response["status"]
		## end

		if status == "clean"
			logger.debug "clean file"
			form.approved = true
			form.save
			return true
		else
			logger.debug "dangerous file"
			Mailer.delay.upload_failed_virus_scan_email(current_user, form)
			return false
		end
	end

	def save_form(form_params)

      @form = Form.new(form_params)
      @form.user_id = current_user.id
      @form.description = form_params[:description]
      @form.jurisdiction = form_params[:jurisdiction]
      @form.practice_area_id = form_params[:practice_area_id]

      if @form.save
        # scan the form for viruses
        if virus_scan(@form) != true
            flash[:error] = "There was a problem with your submission. It appears that the uploaded form is an unsafe document."
            redirect_to share_path
        end

        # opt in the user to following their own form
        @form_follow = FormFollow.new(:user_id => current_user.id, :form_id => @form.id)
        @form_follow.save

        flash[:success] = "Thank you for your contribution!"
        redirect_to form_path(@form.id)
      else
        flash[:error] = "There was a problem with your submission. Please try again."
        redirect_to share_path
      end
	end

	def save_form_with_source_comment_id(form_params, source_comment_id)

      @form = Form.new(form_params)
      @form.user_id = current_user.id
      @form.description = form_params[:description]
      @form.jurisdiction = form_params[:jurisdiction]
      @form.sourcecomment_id = source_comment_id 
      @form.practice_area_id = form_params[:practice_area_id]

      if @form.save
        # scan the form for viruses
        if virus_scan(@form) != true
            flash[:error] = "There was a problem with your submission. It appears that the uploaded form is an unsafe document."
            redirect_to share_path
        end

        # opt in the user to following their own form
        @form_follow = FormFollow.new(:user_id => current_user.id, :form_id => @form.id)
        @form_follow.save

        return true
      else
        return false
      end
	end

	def save_request(params)

	  # create a new request submission
      @request_submission = RequestSubmission.new(:form_request_id => params[:requestid], 
        :comment => params[:request_submission][:comment], :user_id => current_user.id)
      
      # save the request submission
      if !@request_submission.save
        flash[:error] = "There was a problem with your submission. Please try again."
        redirect_to root_path
        return
      end

      @request = FormRequest.find(params[:requestid])
      @requestowner = User.find(@request.user.id)

      @form = Form.new(params[:form])
      @form.user_id = current_user.id
      @form.description = params[:form][:description]
      @form.jurisdiction = params[:form][:jurisdiction]
      @form.practice_area_id = @request.practice_area_id

      # save the form
      if @form.save
        flash[:success] = "Thank you for your contribution!"
        @request_submission.form_id = @form.id
        @request_submission.save

        # scan the form for viruses
        if virus_scan(@form) != true
          @request_submission.destroy
          flash[:error] = "There was a problem with your submission. It appears that the uploaded form is an unsafe document."
          redirect_to form_request_path(@request)
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
        flash[:error] = "There was a problem with your submission. Please try again."
      end

      redirect_to form_request_path(@request)
	end
end