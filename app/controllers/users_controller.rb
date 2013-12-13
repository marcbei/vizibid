class UsersController < ApplicationController
  include UsersHelper

  before_filter :signed_in_user, only: [:edit, :update, :show]
  before_filter :correct_user,   only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
    # pull data for the profile page
    name = params[:name].gsub('_', ' ')
  	@user = User.all(:conditions => ['name ILIKE ?', name]).first
    if @user.id == current_user.id
      @show_edit = true
    end

    if name.downcase.eql? "vizibid"
      @vizibid_account = true
    end

    @formdownloads = @user.downloads.order("created_at asc")
    @formdownloads_a = FormDownload.find_all_by_user_id(@user.id)
    @formdownloads_count = @user.downloads.count
    if @formdownloads_count == nil
      @formdownloads_count = 0
    end

    @formshared = @user.forms.order("created_at asc")
    @formshared_count = @user.forms.count
    if @formshared_count == nil
      @formshared_count = 0
    end

    @formrequests = @user.form_requests.order("created_at asc").find_by_anonymous(false)
    @commentcount = @user.comments.count
    @comments = @user.comments.order("created_at desc").group_by{|c| c.form_id}

  end

  def create
  	# create the user

    if params[:AccessCode].downcase != 'lawdoc1'
      flash[:error] = "Access code is not correct. Contact info@vizibid.com to get the access code."
      redirect_to root_path
      return
    end

    @user = User.new(params[:user])
    @user.verified = false
    @user.verification_token = SecureRandom.urlsafe_base64
    @user.verification_token_sent_at = Time.zone.now

  	if @user.save
      # create the default user details and notifications
      @user_details = UserDetail.new(:user_id => @user.id, :show_comments => false, 
        :show_uploaded => false, :show_requests => false, :show_location => false, :show_website => false,
        :show_bio => false, :show_practice_area => false, :show_email => false)

      @user_notifications = UserNotification.new(:user_id => @user.id, :requests => true,
        :forms => true, :news => true, :tips => true, :surveys => true)
      
      practice_areas.each do |p|
        UserPracticeArea.new(:user_id => @user.id, :practice_area_id => p[1]).save
      end

      if @user_details.save && @user_notifications.save
        # set permissions
        set_permissions(@user, '712')
        
        # verify the user
        verify_user(@user)
        return
      end
  	else
      flash[:error] = "Unable to create your account. Please try again."
      redirect_to root_path
    end
      
  end

  def verify
    # verify the user
    @user = User.find_by_verification_token(params[:id])
    
    if @user.verification_token_sent_at < 24.hours.ago
      flash[:error] = "It has been over 24 hours since you signed up. Please try again."
      @user.destroy
    else
      @user.verified = true
      @user.save
      flash[:success] = "Welcome to Vizibid!"
      sign_in @user
    end

    redirect_to root_path
  end

  def edit

  end

  def update

        @user = current_user

        # update username and/or email address
       # if params[:account_reset] == "true"

        #  if params[:user][:name] != nil && params[:user][:name] != "" && params[:user][:name] != @user.name
         #     @user.name = params[:user][:name]
         # end

          #if params[:user][:email] != nil && params[:user][:email] != "" && params[:user][:email] != @user.email
              #@user.email = params[:user][:email]
          #end

          #if @user.save
           # sign_in(User.find(@user.id))
            #flash[:success] = "Updated account settings"
            
          #else
           # flash[:error] = "Unable to update account settings"
         # end
          
        # update password
        if params[:password_reset] == "true"
         if @user.authenticate(params[:user][:password]) && params[:user][:password].length >= 6 && params[:user][:newpassword].length >= 6 && params[:user][:newpassword_confirmation].length >= 6
              @user.password = params[:user][:newpassword]
              @user.password_confirmation = params[:user][:newpassword_confirmation]
              @user.save
              sign_in(User.find(@user.id))
              flash[:success] = "Updated password"
          else
            flash[:error] = "Unable to update password"
          end
        end

        redirect_to settings_path("password")
  end
end
