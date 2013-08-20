class SharedFormsController < ApplicationController

	before_filter :signed_in_user

	def create

		@sharedForm = SharedForm.new(:user_id => current_user.id, :form_id => params[:id], :email_address => params[:Email], :description => params[:description])
		
		if @sharedForm.save
			Mailer.delay.share_form_mail(current_user, @sharedForm)
		end

		flash[:success] = "Thank you for sharing this document."
		redirect_to form_path(params[:id])
	end

end