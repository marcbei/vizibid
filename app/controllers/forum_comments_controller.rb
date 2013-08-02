### This code is not used and is not being maintained.
### Marc Beitchman 8/2/2013

class ForumCommentsController < ApplicationController
  include ForumCommentHelper

  before_filter :signed_in_user

  def create

	if params[:forum_comment][:content].empty?
		flash[:error] = "Unable to create your comment. The comment requires text."
		redirect_to forum_post_path(params[:forum_comment][:post_id])
		return
	end

  	@forum_comment = ForumComment.new
	@forum_comment.user_id = current_user.id
	@forum_comment.content = params[:forum_comment][:content]
	@forum_comment.forum_post_id = params[:forum_comment][:post_id]
	
	if params[:forum_comment][:parent_id].to_i != -1
		@forum_comment.parent_id = params[:forum_comment][:parent_id]
	end

	if @forum_comment.save
		flash[:success] = "Thank you for your contribution!"
	else
		flash[:error] = "Unable to create your comment."
	end

    @commentvote = ForumCommentVote.new
  	@commentvote.user_id = current_user.id
  	@commentvote.comment_id = @forum_comment.id
  	@commentvote.value = 1
  	@commentvote.save
  	update_forum_comment_score(@forum_comment.id)

  	redirect_to forum_post_path(params[:forum_comment][:post_id])
  end

  def delete_forum_comment
    @comment = ForumComment.find(params[:id])

    if @comment.has_children?
      @comment.content = "[Deleted]"
      @comment.user_id = nil
      @comment.save
    else
      delete_comment(@comment)
    end

    redirect_to forum_post_path(params[:forumpostid])
  end

  def update

	  if params[:id] != nil
	    @comment = ForumComment.find(params[:id])
	    @commentvote = ForumCommentVote.find_by_comment_id_and_user_id(params[:id], current_user.id)

	    if @comment.user.id != current_user.id

	      if @commentvote == nil
	        @commentvote = ForumCommentVote.new
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
	       update_forum_comment_score(params[:id])
	       @comment = ForumComment.find(params[:id])
	       @commentvote = ForumCommentVote.find_by_comment_id_and_user_id(params[:id], current_user.id)

	     end
	   end

  	respond_to do |format|
          format.js  
      end
  end

 end