class FormRequestsController < ApplicationController

	before_filter :signed_in_user

	def new
		@form_request = FormRequest.new
	end

	def create
		@form_request = FormRequest.new(params[:form_request])
		@form_request.user_id = current_user.id
		#@form_request.description = params[:form_request][:description]
		#@form_request.keywords = params[:form_request][:keywords]
		#@form_request.anonymous = params[:form_request][:anonymous]
		#@form_request.name = params[:form_request][:name]

		if @form_request.save
		  flash[:success] = "Thank you for your request!"
		else
		  flash.now[:error] = "There was a problem with your request. Please try again."
		end

		redirect_to requestcenter_path
	end
end
