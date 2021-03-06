class UserFeedbacksController < ApplicationController

	before_filter :signed_in_user

	def create
		@userfeedback = UserFeedback.new(:subject => params[:user_feedback][:subject], 
			:comment => params[:user_feedback][:comment], :user_id => current_user.id)

		if @userfeedback.save
			flash[:success] = "We received your feedback. Thank you."
			Mailer.delay.feedback_email(current_user, @userfeedback.subject, @userfeedback.comment)
			redirect_to root_path
		else
			flash[:error] = "Unable to submit your feedback. You can email feedback to suggestions@vizibid.com."
			redirect_to root_path
		end
	end

end
