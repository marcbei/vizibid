class CommentsController < ApplicationController
  
  before_filter :signed_in_user

  def create
    @comment = current_user.comments.build(params[:comment])
    #todo: probably a better way to do this
    @comment.form_id = params[:form_id]
    if @comment.save
      flash[:success] = "Thank you for your comment!"
    else
      flash[:error] = "Sorry, we are unable to save your comment."
    end

      redirect_to form_path(@comment.form_id)
  end

  def destroy

  end
end