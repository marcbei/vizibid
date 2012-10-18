
class CommentsController < ApplicationController
  
  include CommentHelper

  before_filter :signed_in_user

  def create

    if(params[:comment][:form_id] != nil && params[:comment][:parent_id] != "-1" )

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

      @commentvote = CommentVote.new
      @commentvote.user_id = current_user.id
      @commentvote.comment_id = @comment.id
      @commentvote.value = 1
      @commentvote.save
      update_comment_score(@comment.id)

      @rootform = Form.find(params[:comment][:form_id])
      @formowner = User.find(@rootform.user.id)
      if @formowner.user_notification.forms == true && current_user.id != @formowner.id
        Mailer.delay.doc_comment_mail(current_user, @rootform, @formowner, @comment) 
      end

      redirect_to form_path(params[:comment][:form_id])

    else
      @comment = current_user.comments.new
      @comment.form_id = params[:comment][:form_id]
      @comment.user_id = current_user.id
      @comment.parent_id = nil
      @comment.content = params[:comment][:content]
      
      if @comment.save
        flash[:success] = "Thank you for your comment!"
      else
        flash[:error] = "Sorry, we are unable to save your comment."
      end

      @commentvote = CommentVote.new
      @commentvote.user_id = current_user.id
      @commentvote.comment_id = @comment.id
      @commentvote.value = 1
      @commentvote.save
      update_comment_score(@comment.id)

      @rootform = Form.find(params[:comment][:form_id])
      @formowner = User.find(@rootform.user.id)
      if @formowner.user_notification.forms == true && current_user.id != @formowner.id
        Mailer.delay.doc_comment_mail(current_user, @rootform, @formowner, @comment) 
      end

      redirect_to form_path(@comment.form_id)
    end
  end

  def new
    @comment = current_user.comments.new(:parent_id => params[:parent_id], :form_id => params[:form_id])
  end

  def update

      if params[:id] != nil
        @comment = Comment.find(params[:id])
        @commentvote = CommentVote.find_by_comment_id_and_user_id(params[:id], current_user.id)

        if @comment.user.id != current_user.id

          if @commentvote == nil
            @commentvote = CommentVote.new
            @commentvote.user_id = current_user.id
            @commentvote.comment_id = params[:id] 
            
            if params[:vote] == "pos"
              @commentvote.value = 1
            elsif params[:vote] == "neg"
              @commentvote.value = -1
            end

            @commentvote.save
          else
            if(@commentvote.value == 1)
              if(params[:vote] == "pos")
                @commentvote.destroy
              else
                @commentvote.value = -1
                @commentvote.save
              end
            elsif(@commentvote.value == -1)
              if(params[:vote] == "neg")
                @commentvote.destroy
              else
                @commentvote.value = 1
                @commentvote.save
              end
            end
          end

          # refresh the data
          update_comment_score(params[:id])
          @comment = Comment.find(params[:id])
          @commentvote = CommentVote.find_by_comment_id_and_user_id(params[:id], current_user.id)

        end
      end
      
      respond_to do |format|
          format.js  
      end
  end

  def destroy

    @comment = Comment.find(params[:id])

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