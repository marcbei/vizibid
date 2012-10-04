class CommentsController < ApplicationController
  
  before_filter :signed_in_user

  def create

    if(params[:comment][:form_id] != nil && params[:comment][:parent_id] != nil)

      @comment = Comment.new
      @comment.user_id = current_user.id
      @comment.form_id = params[:comment][:form_id]
      @comment.parent_id = params[:comment][:parent_id]
      @comment.content = params[:comment][:content]

      if @comment.save
        if params[:upload] != "yes"
          flash[:success] = "Thank you for your comment!"
        end
      else
        flash[:error] = "Sorry, we are unable to save your comment."
        redirect_to form_path(params[:comment][:form_id])
        return
      end

      if params[:upload] == "yes"

        @form = Form.new(params[:form])
        @form.form = params[:form][:form]
        @form.user_id = current_user.id
        @form.sourcecomment_id = @comment.id

        if @form.save
          flash[:success] = "Thank you for your comment and document!"
        else
          @comment.destroy
          flash[:error] = "Sorry, we are unable to save your comment."
        end
      end

      redirect_to form_path(params[:comment][:form_id])

    else
      @comment = current_user.comments.build(params[:comment])
      @comment.form_id = params[:form_id]
      
      if @comment.save
        flash[:success] = "Thank you for your comment!"
      else
        flash[:error] = "Sorry, we are unable to save your comment."
      end

      redirect_to form_path(@comment.form_id)
    end
  end

  def new
    @comment = current_user.comments.new(:parent_id => params[:parent_id], :form_id => params[:form_id])
    
  end

  def destroy

  end
end