class PagesController < ApplicationController
  
  require 'will_paginate/array'

  def home
    @home = true
  	if signed_in? 
      if params[:search] == nil || params[:search].empty?
        @forms = nil

        if params[:tab] == "requests"
          @form_requests = FormRequest.order("created_at DESC").find(:all, :conditions => [ "user_id = '#{current_user.id}' and fufilled != true"])
          @open_req = true
        elsif params[:tab] == "followed"
          @followedforms = FormFollow.find(:all, :conditions => ["user_id = '#{current_user.id}'"]).sort_by{|f| f.form.updated_at}.reverse
        elsif params[:tab] == "feed"
          @subscribedforms = Array.new
          UserPracticeArea.find(:all, :conditions => ["user_id = '#{current_user.id}'"]).each{|pa| @subscribedforms = @subscribedforms + pa.practice_area.forms}
          @subscribedforms = @subscribedforms.sort_by(&:updated_at).reverse
        else
          # call helper to get appropriate data
          @form = Form.new
          @requestresponse = RequestSubmission.new
          @subscribedformrequests = Array.new
          UserPracticeArea.find(:all, :conditions => ["user_id = '#{current_user.id}'"]).each{|pa| @subscribedformrequests = @subscribedformrequests + pa.practice_area.form_requests}

          @subscribedformrequests = @subscribedformrequests.shuffle
          if @subscribedformrequests.count > 20 
            @subscribedformrequests = @subscribedformrequests.first(20)
          end
        end 

      else
        @search = Form.search do
          with(:approved, true)
          fulltext params[:search]
        end
        
        # don't log requests after pagination
        if params[:page] == nil
          SearchQuery.create(:user_id => current_user.id, :query => params[:search])
        end
        
        @forms = @search.results
        @total_forms = @forms.count
        @forms = @forms.paginate(:page => params[:page], :per_page => 10)
      end
  	else
  		@user = User.new
  	end

    respond_to do |format|
      format.js  
      format.html
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
  	signed_in_user

    if check_permissions(nil) != true
      flash[:error] = "You don't have access to this feature. Please upgrade your account."
      redirect_to root_path
      return
    end

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

    @permitted_user = check_permissions(nil)
    @total_requests = @form_requests.count
    @form_requests = @form_requests.paginate(:page => params[:page], :per_page => 5)

  end

  def history
    signed_in_user

    if params[:tab] == "downloaded"
      if params[:sort] == "alpha"
        @formdownloads = FormDownload.find_all_by_user_id(current_user.id, :include => [:form], :order => 'LOWER(forms.name)')
      else
        @formdownloads = current_user.form_downloads.order("created_at desc")
      end
    elsif params[:tab] == "uploaded"
      if params[:sort] == "alpha"
        @uploadedforms = current_user.forms.order("LOWER(name)")
      else
        @uploadedforms = current_user.forms.order("created_at desc")
      end
    elsif params[:tab] == "searches"
      if params[:sort] == "alpha"
        @searchqueries = current_user.search_queries.order("LOWER(query)")
      else
        @searchqueries = current_user.search_queries.order("created_at desc")
      end
    else
      if params[:sort] == "alpha"
        @viewedforms = FormView.find_all_by_user_id(current_user.id, :include => [:form], :order => 'LOWER(forms.name)')
      else
        @viewedforms = current_user.form_views.order("created_at desc")
      end
    end

    respond_to do |format|
      format.js  
      format.html
    end

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
    @permitted_user = check_permissions(nil)

  end

  def settings
    signed_in_user
  end
end
