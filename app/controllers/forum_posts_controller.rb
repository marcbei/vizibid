class ForumPostsController < ApplicationController

	before_filter :signed_in_user

	def create
		
		if params[:forum_post][:title].empty?
			flash[:error] = "Unable to create your post. A forum post requires a title."
			redirect_to forum_path
			return
		end

		@forum_post = ForumPost.new
		@forum_post.user_id = current_user.id
		@forum_post.title = params[:forum_post][:title]
		@forum_post.message = params[:forum_post][:message]
		
		if @forum_post.save
			flash[:success] = "Thank you for your contribution!"
			redirect_to forum_post_path(@forum_post)
			return
		else
			flash[:error] = "Unable to create your post."
			redirect_to forum_path
		end
	end

	def show

		@sorted = "top"
	    if params[:sorted_by] == "new"
	      @sort_by = "new"
	    elsif params[:sorted_by] == "old"
	      @sort_by = "old"
	    end 

		@post = ForumPost.find(params[:id])
		@forumcomment = ForumComment.new
		@comments = @post.forum_comments

		respond_to do |format|
          format.js  
          format.html
      	end
	end

end
