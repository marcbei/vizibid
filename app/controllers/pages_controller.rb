class PagesController < ApplicationController
  def home
  	
  	if signed_in?
  		@forms = Form.search(params[:search])  		
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
end
