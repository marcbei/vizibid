class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]
  #before_filter :correct_user,   only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    
    @formdownloads_count = @user.downloads.count
    if @formdownloads_count == nil
      @formdownloads_count = 0
    end

    @formshared_count = @user.forms.count
    if @formshared_count == nil
      @formshared_count = 0
    end

    @formshared = @user.forms

  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      
      @user_details = UserDetail.new
      @user_details.user_id = @user.id
      
      @user_notifications = UserNotification.new
      @user_notifications.user_id = @user.id
      @user_notifications.requests = true
      @user_notifications.forms = true
      @user_notifications.news = true
      @user_notifications.tips = true
      @user_notifications.surveys = true
      
      if @user_details.save && @user_notifications.save
        flash[:success] = "Welcome to Vizibid!"
        sign_in @user
  		  redirect_to root_path
      else
        render 'new'
      end
  	else
  		render 'new'
  	end
  end

  def edit

  end

  def update

        @user = current_user

        if params[:user][:name] != nil
          @user.name = params[:user][:name]
        end

        if params[:user][:email] != nil
          @user.email = params[:user][:email]
        end

        if @user.save
          flash[:success] = "User details updated"
        else
          flash[:error] = "Unable to update user details"
        end

        redirect_to settings_path("account")
  end

end
