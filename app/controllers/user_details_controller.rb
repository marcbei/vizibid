class UserDetailsController < ApplicationController
	include UserDetailsHelper
	before_filter :signed_in_user, only: [:edit, :update]

	def update

		# verify the user
		@user_detail = UserDetail.find(params[:id])
		correct_user_with_id(@user_detail.user.id)

		# update the user details
		update_user_details(params, current_user)

		# save the changes
		if current_user.user_detail.save
			flash[:success] = "Profile settings updated"
		else
			flash[:error] = "Unable to save profile settings"
		end

		redirect_to settings_path("profile")
	end

end