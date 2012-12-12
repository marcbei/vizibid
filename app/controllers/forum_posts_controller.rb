class ForumPostsController < ApplicationController

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
		else
			flash[:error] = "Unable to create your post."
		end

		redirect_to forum_path

	end

	def show
		@post = ForumPost.find(params[:id])
	end

end
