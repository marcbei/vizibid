class InappropriateDocumentsController < ApplicationController

	def create
		@inappropriate_document = InappropriateDocument.new
		@inappropriate_document.user_id = current_user.id
		@inappropriate_document.form_id = params[:formid]

		@form = Form.find(@inappropriate_document.form_id)
		@user = User.find(@inappropriate_document.user_id)

		if @inappropriate_document.save
			flash[:success] = "Thank your for your report!"
			Mailer.inappropriate_document_email(@user, @form).deliver
		else
			flash[:error] = "Sorry, we did mot receive your report."
		end

		redirect_to form_path(params[:formid])
	end
end
