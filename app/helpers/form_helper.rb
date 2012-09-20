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
end