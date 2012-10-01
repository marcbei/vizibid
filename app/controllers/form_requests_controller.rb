class FormRequestsController < ApplicationController

	before_filter :signed_in_user

	def new
		@form_request = FormRequest.new
	end

	def create
		@form_request = FormRequest.new(params[:form_request])
		@form_request.user_id = current_user.id
		@form_request.fufilled = false

		if @form_request.save
		  flash[:success] = "Thank you for your request!"
		else
		  flash.now[:error] = "There was a problem with your request. Please try again."
		end

		redirect_to requestcenter_path
	end

	def update

		@form_request = FormRequest.find(params[:id])

 		@form_request.update_attributes(params[:form_request])
		if @form_request.save
		  flash[:success] = "Edits saved!"
		else
		  flash.now[:error] = "There was a problem with your request. Please try again."
		end

		redirect_to form_request_path(params[:id])
	end

	def show
		@form_request = FormRequest.find(params[:id])

		@inappropriate_request_report = InappropriateRequest.find_by_user_id_and_request_id(current_user.id, @form_request .id)
    	@ir = InappropriateRequest.new

	end

	def edit

		if(params[:comment] == "comment")
			# make this show a different form for comments 
		end

		@form_request = FormRequest.find(params[:id])

		@form = Form.new
	end

	def destroy
		@form_request = FormRequest.find(params[:id])
		@form_request.delete

		flash[:success] = "Request deleted!"

		redirect_to requestcenter_path
	end

	def completerequest

		if(params[:id] != nil)
			@form_request = FormRequest.find(params[:id].to_i)
			@form_request.fufilled = true
			@form_request.save
			redirect_to form_request_path(params[:id].to_i)
		else
			redirect_to requestcenter_path
		end
	end
end
