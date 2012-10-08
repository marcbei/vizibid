module CommentHelper

	def update_comment_score(comment_id)
		comment = Comment.find(comment_id)
		comment_votes = CommentVote.find_all_by_comment_id(comment_id)

		sum = comment_votes.sum(&:value)

		comment.score = sum

		comment.save
	end

	def user_has_voted(comment_id)
		@commentvote = CommentVote.find_by_comment_id_and_user_id(comment_id, current_user.id)

		if @commentvote == nil
			return false
		else
			return true
		end
	end
end