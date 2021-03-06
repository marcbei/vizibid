module FormRequestsHelper

	def nested_request_responses(responses)
		responses.map do |response, sub_responses|
      		render('form_requests/request_response_summary', :f => response) + content_tag(:div, nested_request_responses(sub_responses), :class => "nested_responses")
    	end.join.html_safe
	end

	def delete_response(response)
		parent = response.parent
		response.destroy
		
		if parent != nil && parent.comment == "[Deleted]" && parent.is_childless?
			parent.destroy
		else
			response.destroy
		end
	end
end
