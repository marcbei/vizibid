class InappropriateRequestsController < ApplicationController

	def create
		@inappropriate_request = InappropriateRequest.new(:user_id => current_user.id,
			:request_id => params[:requestid])

		@request = FormRequest.find(@inappropriate_request.request_id)
		@user = User.find(@inappropriate_request.user_id)

		if params[:inappropriate_request][:reason] == "option1"

			@inappropriate_request.reason  = "Request contains inappropriate content"

		elsif params[:inappropriate_request][:reason] == "option2"

			@inappropriate_request.reason  = "Request description is misleading"

		elsif params[:inappropriate_request][:reason] == "other"

			@inappropriate_request.reason  = "other"
		end

		if @inappropriate_request.save
			flash[:success] = "Thank your for your report!"
			Mailer.delay.inappropriate_request_email(@user, @request, @inappropriate_request.reason)
		else
			flash[:error] = "Sorry, we did not receive your report."
		end

		redirect_to form_request_path(params[:requestid])
	end
end