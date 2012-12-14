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

	if @forum_comment.save
		flash[:success] = "Thank you for your contribution!"
	else
		flash[:error] = "Unable to create your comment."
	end

  	redirect_to forum_post_path(params[:forum_comment][:post_id])
  end

 end