class InappropriateDocumentsController < ApplicationController

	def create
		@inappropriate_document = InappropriateDocument.new(:user_id => current_user.id, 
			:form_id => params[:formid])
		@form = Form.find(@inappropriate_document.form_id)
		@user = User.find(@inappropriate_document.user_id)

		if params[:inappropriate_document][:reason] == "option1"

			@inappropriate_document.reason = "Form contains inappropriate content"

		elsif params[:inappropriate_document][:reason] == "option2"

			@inappropriate_document.reason = "Form description is misleading"

		elsif params[:inappropriate_document][:reason] == "other"

			@inappropriate_document.reason = "other"
		end

		if @inappropriate_document.save
			flash[:success] = "Thank your for your report!"
			Mailer.delay.inappropriate_document_email(@user, @form, @inappropriate_document.reason)
		else
			flash[:error] = "Sorry, we did mot receive your report."
		end

		redirect_to form_path(params[:formid])
	end
end
