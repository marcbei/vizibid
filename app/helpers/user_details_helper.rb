module UserDetailsHelper

	def update_user_details(params, current_user)
		if !IsNilOrEmpty(params[:user_detail][:location])
			current_user.user_detail.location = params[:user_detail][:location]
		end

		if !IsNilOrEmpty(params[:user_detail][:website])
			current_user.user_detail.website = params[:user_detail][:website]
		end

		if !IsNilOrEmpty(params[:user_detail][:practice_area])
			current_user.user_detail.practice_area = params[:user_detail][:practice_area]
		end

		if !IsNilOrEmpty(params[:user_detail][:bio])
			current_user.user_detail.bio = params[:user_detail][:bio]
		end

		if !IsNilOrEmpty(params[:user_detail][:show_comments])
			current_user.user_detail.show_comments = params[:user_detail][:show_comments]
		end

		if !IsNilOrEmpty(params[:user_detail][:show_uploaded])
			current_user.user_detail.show_uploaded = params[:user_detail][:show_uploaded]
		end

		if !IsNilOrEmpty(params[:user_detail][:show_requests])
			current_user.user_detail.show_requests = params[:user_detail][:show_requests]
		end
	end

end