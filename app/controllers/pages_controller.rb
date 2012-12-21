class PagesController < ApplicationController
  
  require 'will_paginate/array'

  def home
  	if signed_in? 
      @feedback = UserFeedback.new
      if params[:search] == nil || params[:search].empty?
        @forms = nil
      else
        @search = Form.search do
          fulltext params[:search]
        end
        @forms = @search.results
        @total_forms = @forms.count
        @forms = @forms.paginate(:page => params[:page], :per_page => 5)
      end
  	else
  		@user = User.new
  	end
  end

  def about
    if !signed_in?
      @user = User.new
    end
  end

  def contactus
    if !signed_in?
      @user = User.new
    end
  end

  def why
    if !signed_in?
      @user = User.new
    end
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

    @total_requests = @form_requests.count
    @form_requests = @form_requests.paginate(:page => params[:page], :per_page => 5)

  end

  def history
    signed_in_user

    @formdownloads = current_user.downloads.order("created_at asc")
    @fd = current_user.form_downloads.order("created_at asc")
    @formrequests = current_user.form_requests.order("created_at asc")
    @uploadedforms = current_user.forms.order("created_at asc")
    @comments = current_user.comments.order("created_at desc").group_by{|c| c.form_id}
  end

  def forum

    signed_in_user

    if params[:search] == nil || params[:search].empty?
      @forumposts = nil
    else
      @search = ForumPost.search do
        fulltext params[:search]
      end
      @forumposts = @search.results
    end

    if @forumposts != nil
      @total_posts = @forumposts.count
      @forumposts = @forumposts.paginate(:page => params[:page], :per_page => 5)
    end

    @forumpost = ForumPost.new

  end

  def settings
    signed_in_user
  end
end
