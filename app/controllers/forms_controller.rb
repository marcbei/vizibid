class FormsController < ApplicationController
  
  before_filter :signed_in_user

  def create
  	@form = Form.new(params[:form])
    @form.user_id = current_user.id
    @form.num_downloads = 0
    
    if @form.save
      flash[:success] = "Thank you for your contribution!"
    else

      flash.now[:error] = "There was a problem with your submission. Please try again."
    end

    redirect_to root_path
  end

  def show
    @form = Form.find(params[:id])
    @comments = @form.comments
    @comment = current_user.comments.build
    @user = @form.user.name
  end

  def download
    @form = Form.find(params[:id])
    @form.num_downloads += 1
    @form.save

    redirect_to @form.form.url
  end

end