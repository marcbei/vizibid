class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to Vizibid!"
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def edit

  end

  def update

        #@user = User.find(current_user.id)
        #@user.email = params[:user][:email]
        #@user.save
        redirect_to settings_path("account")
  end

end
