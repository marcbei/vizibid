class FormRatingsController < ApplicationController

	before_filter :signed_in_user

	def create
		@form = Form.find_by_id(params[:formid])
		@formrating = current_user.form_ratings.find_by_form_id(@form.id)
		
		if(current_user.id == @form.user.id)
			flash[:error] = "You cannot rate your own form."
			redirect_to form_path(@form)
		# kind of a hack, form should really reload and submit a put instead of post, oh well
		elsif @formrating  != nil
			@formrating.value = params[:rating][:value]
            if@formrating.save
                respond_to do |format|
                    format.html { redirect_to form_path(@form), :notice => "Your rating has been updated" }
                    format.js
                end
            end
		else
			@formrating = FormRating.new
			@formrating.form_id = @form.id
			@formrating.user_id = current_user.id
			@formrating.value = params[:rating][:value]

			if(@formrating.save)
				respond_to do |format|
                        format.html { redirect_to form_path(@form), :notice => "Your rating has been saved" }
                        format.js
                end
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
