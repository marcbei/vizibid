class PagesController < ApplicationController
  def home
  	
  	if signed_in? 

      if params[:search] == nil || params[:search].empty?
        @forms = nil
      else
        @forms = Form.search(params[:search])
      end

  	else
  		@user = User.new
  	end
  end

  def about
  end

  def share
  	# make sure the user is signed in
  	signed_in_user

  	@form = Form.new
  end

  def requestcenter
    signed_in_user

    if(params[:scope] == "me")
      @form_requests = FormRequest.find(:all, :conditions => [ "user_id = '#{current_user.id}'"])
    else
      @form_requests = FormRequest.find(:all, :conditions => [ "fufilled != true"])
    end

  end

  def history
    signed_in_user
  end

end
