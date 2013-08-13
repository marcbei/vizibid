
class CommentsController < ApplicationController
  
  include CommentHelper

  before_filter :signed_in_user

  def create

    # set the appropriate parent id
    if params[:comment][:parent_id] == "-1"
      params[:comment][:parent_id] = nil
    end

    # create the new comment
    @comment = Comment.new(:user_id => current_user.id, :form_id => params[:comment][:form_id], 
      :parent_id => params[:comment][:parent_id], :content => params[:comment][:content])

    # save the comment
    if @comment.save
      if params[:upload] != "yes"
        @form = Form.find(params[:comment][:form_id])
        @form.touch
        flash[:success] = "Thank you for your comment!"
      end
    else
      flash[:error] = "Sorry, we are unable to save your comment."
      redirect_to form_path(params[:comment][:form_id])
      return
    end

    # upload the associated document
    if params[:upload] == "yes"

      @form = Form.new(params[:form], :form => params[:form][:form], :user_id => current_user.id, :sourcecomment_id => @comment.id)

      if @form.save
        flash[:success] = "Thank you for your comment and document!"
      else
        # destroy the comment of the form did not save
        @comment.destroy
        flash[:error] = "Sorry, we are unable to save your comment."
      end
    end

    # create the associated comment vote for this new comment
    @commentvote = CommentVote.new(:user_id => current_user.id, :comment_id => @comment.id, :value => 1)
    @commentvote.save
    
    update_comment_score(@comment.id)     

    # send the owner of the root document a notiication of the new comment if they are subscribed
    @rootform = Form.find(params[:comment][:form_id])
    if @rootform.user.user_notification.forms == true && current_user.id != @rootform.user.id
      Mailer.delay.doc_comment_mail(current_user, @rootform, @rootform.user, @comment) 
    end

    redirect_to form_path(params[:comment][:form_id])

  end

  def new
    @comment = current_user.comments.new(:parent_id => params[:parent_id], :form_id => params[:form_id])
  end

  def update
      @comment = Comment.find(params[:id])

      # ensure we have a comment id and that the owner of the comment isn't trying to
      # vote on their own comment
      if params[:id] != nil && @comment.user.id != current_user.id
        
        @commentvote = CommentVote.find_by_comment_id_and_user_id(params[:id], current_user.id)

        # create a new comment vote if it doesn't exist and update the data
        if @commentvote == nil 
          @commentvote = CommentVote.new(:user_id => current_user.id, :comment_id => params[:id]) 
          set_new_commentvote_score(params[:vote], @commentvote)
        else
          set_existing_commentvote_score(params[:vote], @commentvote)
        end

        # refresh the data
        update_comment_score(params[:id])
        @comment = Comment.find(params[:id])
        @commentvote = CommentVote.find_by_comment_id_and_user_id(params[:id], current_user.id)
      end
      
      respond_to do |format|
          format.js  
      end
  end

  def destroy

    @comment = Comment.find(params[:id])

    # delete the comment if it doesn't have children otherwise
    # nil out the comment to preserve the overall acomment structure
    if @comment.has_children?
      @comment.content = "[Deleted]"
      @comment.user_id = nil
      @comment.save
    else
      delete_comment(@comment)
    end

    redirect_to form_path(params[:form_id])
  end
end