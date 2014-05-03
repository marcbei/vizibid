class SharedFormsController < ApplicationController

	before_filter :signed_in_user

	def create
		@f = Form.find(params[:id])

		# charge a download if they are sending themselves a document which they didnt upload
		if params[:Email].downcase == current_user.email.downncase && @f.user.id != current_user.id
		    User.transaction do
		      u = User.find(current_user.id)
		      u.lock!
		      u.save!
		      u.download_allocation = u.download_allocation - 1
		      u.save
		      sign_in u
		    end
		end


		@sharedForm = SharedForm.new(:user_id => current_user.id, :form_id => params[:id], :email_address => params[:Email], :description => params[:description])
		
		if @sharedForm.save
			Mailer.delay.share_form_mail(current_user, @sharedForm)
		end

		flash[:success] = "This document has been emailed to " + params[:Email] + ". Thank you for sharing this document."
		redirect_to form_path(params[:id])
	end

end