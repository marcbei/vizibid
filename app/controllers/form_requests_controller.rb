class FormRequestsController < ApplicationController
	include FormRequestsHelper

	before_filter :signed_in_user

	def new

		if check_permissions(nil) != true
		    flash[:error] = "You don't have access to this feature. Please upgrade your account."
		    redirect_to root_path
	    	return
	    end

		@form_request = FormRequest.new
	end

	def create
		@form_request = FormRequest.new(params[:form_request], :user_id => current_user.id,
			:fufilled => false)

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
		@requestsubmissions = @form_request.RequestSubmissions

		@inappropriate_request_report = InappropriateRequest.find_by_user_id_and_request_id(current_user.id, @form_request .id)
    	@ir = InappropriateRequest.new

    	@form = Form.new
    	@requestresponse = RequestSubmission.new

    	@permitted_user = check_permissions(nil)
	end

	def edit

		@form_request = FormRequest.find(params[:id])

		@form = Form.new
	end

	def destroy
		@form_request = FormRequest.find(params[:id])
		@form_request.delete

		flash[:success] = "Request deleted!"

		redirect_to requestcenter_path
	end

	def destroy_response

		@response = RequestSubmission.find(params[:id])

	    if @response.has_children?
	      @response.comment = "[Deleted]"
	      @response.user_id = nil
	      @response.save
	    else
	      delete_response(@response)
	    end

		redirect_to form_request_path(params[:requestid])

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
