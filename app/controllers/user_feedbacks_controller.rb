class UserFeedbacksController < ApplicationController

	before_filter :signed_in_user

	def create
		@userfeedback = UserFeedback.new
		@userfeedback.subject = params[:user_feedback][:subject]
		@userfeedback.comment = params[:user_feedback][:comment]
		@userfeedback.user_id = current_user.id

		if @userfeedback.save
			flash[:success] = "Feedback submitted. Thank you."
			Mailer.delay.feedback_email(current_user, @userfeedback.subject, @userfeedback.comment)
			redirect_to root_path
		else
			flash[:error] = "Unable to submit your feedback."
			redirect_to feedback_path
		end
	end

end
