class FormRatingsController < ApplicationController

	before_filter :signed_in_user

	def create
		@form = Form.find_by_id(params[:formid])
		@formrating = current_user.form_ratings.find_by_form_id(@form.id)
		
		# make sure the user isn't trying to rate their own for,
		if(current_user.id == @form.user.id)
			flash[:error] = "You cannot rate your own form."
			redirect_to form_path(@form)
		end
		
		# kind of a hack, form should really reload and submit a put instead of post to handle rating updates
		if @formrating  != nil
			@formrating.value = params[:rating][:value]
		# create a new rating
		else
			@formrating = FormRating.new(:form_id => @form.id, :user_id => current_user.id, 
				:value => params[:rating][:value])
		end

        if @formrating.save
	        respond_to do |format|
	            format.html { redirect_to form_path(@form), :notice => "Your rating has been updated" }
	            format.js
	        end
    	end

	end

	def update
		@form = Form.find_by_id(params[:formid])
		if(current_user.id == @form.user.id)
			flash[:error] = "You cannot rate your own form."
			redirect_to form_path(@form)
		else
			@formrating = current_user.form_ratings.find_by_form_id(@form.id)
            @formrating.value = params[:rating][:value]
            if@formrating.save
                respond_to do |format|
                    format.html { redirect_to form_path(@form), :notice => "Your rating has been updated" }
                    format.js
                end
            end
		end
	end

end
