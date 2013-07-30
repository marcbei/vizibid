module CommentHelper

	def update_comment_score(comment_id)
		comment = Comment.find(comment_id)
		comment_votes = CommentVote.find_all_by_comment_id(comment_id)

		sum = comment_votes.sum(&:value)

		comment.score = sum

		comment.save
	end

	def delete_comment(comment)
		parent = comment.parent
		comment.destroy
		
		if parent != nil && parent.content == "[Deleted]" && parent.is_childless?
			parent.destroy
		else
			comment.destroy
		end
	end

	def set_new_commentvote_score(vote, commentvote)

		if vote == "pos"
			commentvote.value = 1
		elsif vote == "neg"
			commentvote.value = -1
		end

		commentvote.save
	end

	def set_existing_commentvote_score(vote, commentvote)
	    
	    if(commentvote.value == 1)
	      if(vote == "pos")
	        commentvote.destroy
	      else
	        commentvote.value = -1
	        commentvote.save
	      end
	    elsif(commentvote.value == -1)
	      if(vote == "neg")
	        commentvote.destroy
	      else
	        commentvote.value = 1
	        commentvote.save
	      end
	    end
	end
end