class UserNotificationsController < ApplicationController
	
	before_filter :signed_in_user, only: [:edit, :update]
	#before_filter :correct_user,   only: [:edit, :update]

	def update

		@user_notification = current_user.user_notification
		@user_notification.update_attributes(params[:user_notification])

		flash[:success] = "Notification settings updated"
		redirect_to settings_path("account")

	end

end