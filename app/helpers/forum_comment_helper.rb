module ForumCommentHelper

	def update_forum_comment_score(comment_id)
		comment = ForumComment.find(comment_id)
		comment_votes = ForumCommentVote.find_all_by_comment_id(comment_id)

		sum = comment_votes.sum(&:value)

		comment.score = sum

		comment.save
	end
end