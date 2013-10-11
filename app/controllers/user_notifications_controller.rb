class UserNotificationsController < ApplicationController
	
 	before_filter :signed_in_user, only: [:edit, :update]

	def update

		# verify the user
		@user_notification = UserNotification.find(params[:id])
		correct_user_with_id(@user_notification.user.id)

		# update and save the email settings
		current_user.user_notification.update_attributes(params[:user_notification])

		flash[:success] = "Notification settings updated"
		redirect_to settings_path("notifications")
	end

end