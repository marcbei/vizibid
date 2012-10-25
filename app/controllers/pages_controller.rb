class PagesController < ApplicationController
  def home
  	if signed_in? 

      if params[:search] == nil || params[:search].empty?
        @forms = nil
      else
        @search = Form.search do
          fulltext params[:search]
        end
        @forms = @search.results
      end
      @feedback = UserFeedback.new
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
      if params[:search] == nil || params[:search].empty?
        @form_requests = FormRequest.find(:all, :conditions => [ "fufilled != true"])
      else
        @search = FormRequest.search do
          with(:fufilled, false)
          fulltext params[:search]
        end
        @form_requests = @search.results
      end
    end

  end

  def history
    signed_in_user
    @formdownloads = current_user.downloads
    @fd = current_user.form_downloads
    @formrequests = current_user.form_requests
    @uploadedforms = current_user.forms
    @comments = current_user.comments

  end

  def settings
    signed_in_user
  end
end
