class FormRequestsController < ApplicationController
	
	include FormRequestsHelper

	before_filter :signed_in_user

	def index
		if params[:scope] == "open"
			@form_requests = FormRequest.order("created_at DESC").find(:all, :conditions => [ "user_id = '#{current_user.id}' and fufilled != true"])
			@open_req = true
		elsif params[:scope] == "fulfilled"
			@form_requests = FormRequest.order("created_at DESC").find(:all, :conditions => [ "user_id = '#{current_user.id}' and fufilled = true"])
			@open_req = false
		end

		respond_to do |format|
			format.js
		end

	end

	def new
		if check_permissions(nil) != true
		    flash[:error] = "You don't have access to this feature. Please upgrade your account."
		    redirect_to root_path
	    	return
	    end

		@form_request = FormRequest.new
	end

	def create
		@form_request = FormRequest.new(params[:form_request])
		@form_request.user_id = current_user.id
		@form_request.fufilled = false
		@form_request.practice_area_id = params[:form_request][:practice_area_id]

		if @form_request.save
		  flash[:success] = "Your request was submitted."
		  redirect_to form_request_path(@form_request)
		else
		  flash[:error] = "There was a problem with your request. Please try again."
		  redirect_to root_path
		end
	end

	def update
		@form_request = FormRequest.find(params[:id])
 		@form_request.update_attributes(params[:form_request])
		
		if @form_request.save
		  flash[:success] = "Edits saved!"
		else
		  flash[:error] = "There was a problem with your request. Please try again."
		end
  		 
  		redirect_to form_request_path(@form_request)

	end

	def show
		@form_request = FormRequest.find(params[:id])
		@requestsubmissions = @form_request.RequestSubmissions.order("created_at ASC").find(:all)

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

		redirect_to root_path
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

		respond_to do |format|
			format.js
		end
	end

	def completerequest

		@form_request = FormRequest.find(params[:id])
		@form_request.fufilled = true
		@form_request.save

		# refresh the data
		@form_requests = FormRequest.order("created_at DESC").find(:all, :conditions => [ "user_id = '#{current_user.id}' and fufilled != true"])
		@open_req = true
		
		respond_to do |format|
			format.js
			format.html
		end
	end

	def approveresponse
		@response = RequestSubmission.find(params[:id])
		@response.accepted = true
		@response.save

		respond_to do |format|
			format.js
		end
	end

end
