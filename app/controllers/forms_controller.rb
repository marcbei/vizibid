class FormsController < ApplicationController
  
  before_filter :signed_in_user

  def create
  	@form = Form.new(params[:form])
    
    if @form.save
      flash[:success] = "Thank you for your contribution!"
    else

      flash.now[:error] = "There was a problem with your submission. Please try again."
    end

    redirect_to profile_path
  end

  def show
    @form = Form.find(params[:id])
    @comments = @form.comments
    @comment = current_user.comments.build
  end
end