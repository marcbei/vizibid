class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password]) && user.verified == true
			sign_in user
			redirect_to root_path
		else
			flash[:error] = "Invalid email/password combination."
			redirect_to root_path
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
