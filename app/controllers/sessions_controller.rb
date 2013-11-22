class SessionsController < ApplicationController

	def new
		@sign_in_page = true
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password]) && user.verified == true
			update_sign_in_time user
			sign_in user
			redirect_to root_path
		else
			flash[:error] = "Error signing in. Please try again."
			redirect_to root_path
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
