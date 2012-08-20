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
  end

  def history
    signed_in_user
  end

end
