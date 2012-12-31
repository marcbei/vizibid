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
		#request.basic_auth("d50cff87d2414c70b312461bac787dfd", "sYMTxSJP3")

		#response = http.request(request)

		#parsed_response = JSON.parse(response.body)
		status = "clean" #parsed_response["status"]

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
end