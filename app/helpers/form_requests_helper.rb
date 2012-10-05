module FormRequestsHelper

	def nested_request_responses(responses)
		responses.map do |response, sub_responses|
      		render('layouts/request_response_summary', :f => response) + content_tag(:div, nested_request_responses(sub_responses), :class => "nested_responses")
    	end.join.html_safe
	end

end
