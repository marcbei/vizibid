class FormFollowsController < ApplicationController

	before_filter :signed_in_user

	def update
		# add logic to update the state
		@followingForm = FormFollow.find_by_form_id_and_user_id(params[:id], current_user.id)
		if @followingForm == nil
			@followingForm = FormFollow.new(:form_id => params[:id], :user_id => current_user.id)
			@followingForm.save
			@following = true
		else
			@followingForm.destroy
			@following = false
		end

		respond_to do |format|
			format.js
		end
	end

	def unfollow
		@followingForm = FormFollow.find_by_form_id_and_user_id(params[:id], current_user.id)
		if @followingForm != nil
			@followingForm.destroy
		end

		respond_to do |format|
			format.js
		end
	end
end