module FormHelper
	def ratings_ballot(formid)
		@rating = current_user.form_ratings.find_by_form_id(formid)
		if(@rating != nil)
			@rating
		else
			current_user.form_ratings.new
		end
	end

	def current_user_rating(formid)
	    if @rating = current_user.form_ratings.find_by_form_id(formid)
	        @rating.value
	    else
	        "N/A"
	    end
	end

	def document_downloaded()
		current_user.form_downloads.each do |fd|
			if(fd.form_id == @form.id)
				return true
			end
		end

		return false
	end

	def nested_comments(comments)
		comments.map do |comment, sub_comments|
      		render('forms/comment', :comment => comment) + content_tag(:div, nested_comments(sub_comments), :class => "nested_comments")
    	end.join.html_safe
	end
end