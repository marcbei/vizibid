module UsersHelper

	require 'nokogiri'
	require 'open-uri'

	def verify_user(user)

		if user.state_licensed.downcase == "washington"
			emailaddress = verify_washington_user(user)
		elsif user.state_licensed.downcase == "oregon"
			emailaddress = verify_oregon_user(user)
		end

		if !emailaddress.empty?
			Mailer.user_verification_email(user, emailaddress).deliver		
			flash[:success] = "Verification email has been sent to the email address that is registered with your state's bar association."
		else
			flash[:error] = "Could not verify your identity as a lawyer."
		end

		redirect_to root_path

	end

	def verify_washington_user(user)
		emailaddress = ""
		doc = Nokogiri::HTML(open("http://www.mywsba.org/default.aspx?tabid=178&RedirectTabId=177&Usr_ID=#{user.bar_number}"))
		divs = doc.css("div.inner")
		if (divs.text.include? "Active") && (divs.text.include? user.bar_number.to_s)
			
			doc.css('a.link-copy').each do |email|
				if email.text.include? '@'
					emailaddress = email.text
				end
			end
		end

		return emailaddress
	end

	def verify_oregon_user(user)
		emailaddress = ""
		doc = Nokogiri::HTML(open("http://www.osbar.org/members/display.asp?b=#{user.bar_number}&s=1&aw="))
		divs = doc.css("table.whiteheader") 
		if (divs.text.include? "Active") && (divs.text.include? user.bar_number)
			
			divs.css('a.mlink').each do |email|
				if email.text.include? '@'
					emailaddress = email.text
				end
			end
		end

		return emailaddress
	end
end
