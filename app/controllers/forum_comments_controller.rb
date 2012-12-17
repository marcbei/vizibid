class ForumCommentsController < ApplicationController
  
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

 end