module PagesHelper
      def truncante_description(description)
      	words = description.split(' ')

      	if(words.count > 40)
      		return words[0..40].join(' ')
      	else
      		return description
      	end
      end
end