class InappropriateRequestsController < ApplicationController

	def create
		@inappropriate_request = InappropriateRequest.new
		@inappropriate_request.user_id = current_user.id
		@inappropriate_request.request_id = params[:requestid]

		@request = FormRequest.find(@inappropriate_request.request_id)
		@user = User.find(@inappropriate_request.user_id)


		if params[:inappropriate_request][:reason] == "option1"

			@reason = "Request contains inappropriate content"

		elsif params[:inappropriate_request][:reason] == "option2"

			@reason = "Request description is misleading"

		elsif params[:inappropriate_request][:reason] == "other"

			@reason = "other"
		end

		@inappropriate_request.reason = @reason

		if @inappropriate_request.save
			flash[:success] = "Thank your for your report!"
			Mailer.inappropriate_request_email(@user, @request, @reason).deliver
		else
			flash[:error] = "Sorry, we did mot receive your report."
		end

		redirect_to form_request_path(params[:requestid])
	end
end