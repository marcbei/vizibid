class UserDetailsController < ApplicationController
	
	before_filter :signed_in_user, only: [:edit, :update]

	def update

		@user_detail = UserDetail.find(params[:id])

		correct_user_with_id(@user_detail.user.id)

		@user = current_user

		if !params[:user_detail][:location].nil? && !params[:user_detail][:location].empty?
			@user.user_detail.location = params[:user_detail][:location]
		end

		if !params[:user_detail][:website].nil? && !params[:user_detail][:website].empty?
			@user.user_detail.website = params[:user_detail][:website]
		end

		if !params[:user_detail][:practice_area].nil? && !params[:user_detail][:practice_area].empty?
			@user.user_detail.practice_area = params[:user_detail][:practice_area]
		end

		if !params[:user_detail][:bio].nil? && !params[:user_detail][:bio].empty?
			@user.user_detail.bio = params[:user_detail][:bio]
		end

		if @user.user_detail.save
			flash[:success] = "Profile settings updated"
		else
			flash[:error] = "Unable to save profile settings"
		end

		redirect_to settings_path("account")
	end

end