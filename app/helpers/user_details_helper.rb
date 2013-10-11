module UserDetailsHelper

	def update_user_details(params, current_user)

		if !params[:user_detail][:location].nil?
			current_user.user_detail.location = params[:user_detail][:location]
		end

		if !params[:user_detail][:website].nil?
			current_user.user_detail.website = params[:user_detail][:website]
		end

		if !params[:user_detail][:practice_area].nil?
			current_user.user_detail.practice_area = params[:user_detail][:practice_area]
		end

		if !params[:user_detail][:bio].nil?
			current_user.user_detail.bio = params[:user_detail][:bio]
		end

		if  params[:user_detail][:show_comments] == "1"
			current_user.user_detail.show_comments = true
		else
			current_user.user_detail.show_comments = false
		end

		if params[:user_detail][:show_uploaded] == "1"
			current_user.user_detail.show_uploaded = true
		else
			current_user.user_detail.show_uploaded = false
		end

		if params[:user_detail][:show_requests] == "1"
			current_user.user_detail.show_requests = true
		else
			current_user.user_detail.show_requests = false
		end

		if params[:user_detail][:show_location] == "1"
			current_user.user_detail.show_location = true
		else
			current_user.user_detail.show_location = false
		end

		if params[:user_detail][:show_website] == "1"
			current_user.user_detail.show_website = true
		else
			current_user.user_detail.show_website = false
		end

		if params[:user_detail][:show_bio] == "1"
			current_user.user_detail.show_bio = true
		else
			current_user.user_detail.show_bio = false
		end

		if params[:user_detail][:show_practice_area] == "1"
			current_user.user_detail.show_practice_area = true
		else
			current_user.user_detail.show_practice_area = false
		end

		if params[:user_detail][:show_email] == "1"
			current_user.user_detail.show_email = true
		else
			current_user.user_detail.show_email = false
		end

	end

end