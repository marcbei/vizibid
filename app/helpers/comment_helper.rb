module CommentHelper

	def update_comment_score(comment_id)
		comment = Comment.find(comment_id)
		comment_votes = CommentVote.find_all_by_comment_id(comment_id)

		sum = comment_votes.sum(&:value)

		comment.score = sum

		comment.save
	end
end