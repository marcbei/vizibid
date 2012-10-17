class UsersController < ApplicationController
  include UsersHelper

  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    
    @formdownloads = @user.downloads
    @formdownloads_a = FormDownload.find_all_by_user_id(@user.id)
    @formdownloads_count = @user.downloads.count
    if @formdownloads_count == nil
      @formdownloads_count = 0
    end

    @formshared = @user.forms
    @formshared_count = @user.forms.count
    if @formshared_count == nil
      @formshared_count = 0
    end

    @formrequests = @user.form_requests
    @comments = @user.comments

  end

  def create
  	@user = User.new(params[:user])
    @user.verified = false
    @user.verification_token = SecureRandom.urlsafe_base64
    @user.verification_token_sent_at = Time.zone.now

  	if @user.save
      
      @user_details = UserDetail.new
      @user_details.user_id = @user.id
      @user_details.show_comments = false
      @user_details.show_uploaded = true
      @user_details.show_downloaded = true
      @user_details.show_requests = true
      
      @user_notifications = UserNotification.new
      @user_notifications.user_id = @user.id
      @user_notifications.requests = true
      @user_notifications.forms = true
      @user_notifications.news = true
      @user_notifications.tips = true
      @user_notifications.surveys = true
      
      if @user_details.save && @user_notifications.save
        verify_user(@user)
      else
        render 'new'
      end
  	else
  		render 'new'
  	end
  end

  def verify

    @user = User.find_by_verification_token(params[:id])
    
    if @user.verification_token_sent_at < 24.hours.ago
      flash[:error] = "It has been over 24 hours since you signed up. Please try again."
      @user.destroy
      redirect_to root_path
    else
      @user.verified = true
      @user.save
      flash[:success] = "Welcome to Vizibid!"
      sign_in @user
      redirect_to root_path
    end
  end

  def edit

  end

  def update

        @user = current_user

        if params[:account_reset] == "true"

          if params[:user][:name] != nil && params[:user][:name] != "" && params[:user][:name] != @user.name
              @user.name = params[:user][:name]
          end

          if params[:user][:email] != nil && params[:user][:email] != "" && params[:user][:email] != @user.email
              @user.email = params[:user][:email]
          end

          if @user.save
            sign_in(User.find(@user.id))
            flash[:success] = "Updated account settings"
            redirect_to settings_path("account")
            return
          else
            flash[:error] = "Unable to update account settings"
            redirect_to settings_path("account")
            return
          end

        elsif params[:password_reset] == "true"
         if @user.authenticate(params[:user][:password]) && params[:user][:password].length >= 6 && params[:user][:newpassword].length >= 6 && params[:user][:newpassword_confirmation].length >= 6
              @user.password = params[:user][:newpassword]
              @user.password_confirmation = params[:user][:newpassword_confirmation]
              @user.save
              sign_in(User.find(@user.id))
              flash[:success] = "Updated password"
              redirect_to settings_path("account")
              return
          else
            flash[:error] = "Unable to update password"
            redirect_to settings_path("account")
            return
          end

        end
  end
end
