module UsersHelper

	require 'nokogiri'
	require 'open-uri'

 	def url_with_protocol(url)
    	/http/.match(url) ? url : "http://#{url}"
  	end

	def set_permissions(user, access_code)

		@user_permission = UserPermission.new
 		@user_permission.user_id = user.id

		# this represents a paid account
		if(access_code == '712')
			@user_permission.role_id = 2
		# this represents a limited user
		elsif(access_code == '801')
			@user_permission.role_id = 3
		# this is a default (free account)
		else
			@user_permission.role_id = 1
		end

		@user_permission.save
	end

	def verify_user(user)

		emailaddress = ""
		if user.state_licensed.downcase == "washington"
			emailaddress = verify_washington_user(user)
		elsif user.state_licensed.downcase == "oregon"
			emailaddress = verify_oregon_user(user)
		end

		if emailaddress.to_s.empty?
			flash[:success] = "A verification email will be sent to the email address you signed up with. Follow the instructions in that email to complete the registration process."
		else
			flash[:success] = "A verification email will be sent to the email address on file with the bar association. Follow the instructions in that email to complete the registration process."
		end

		Mailer.delay.user_verification_email(user, emailaddress)		

		redirect_to root_path

	end

	def verify_washington_user(user)
		emailaddress = ""
		splitname = user.name.split(' ')
		index = splitname.length-1
		lastname = splitname[index].to_s.downcase
		begin
			doc = Nokogiri::HTML(open("https://www.mywsba.org/LawyerDirectory/LawyerProfile.aspx?Usr_ID=#{user.bar_number}"))
			divs = doc.css("div.inner")
			if (divs.text.include? "Active") && (divs.text.include? user.bar_number.to_s) && (divs.text.downcase.include? lastname)
				doc.css('a.link-copy').each do |email|
					if email.text.include? '@'
						emailaddress = email.text
					end
				end
			end
		rescue
			emailaddress = ""
		end

		return emailaddress
	end

	def verify_oregon_user(user)
		emailaddress = ""
		splitname = user.name.split(' ')
		index = splitname.length-1
		lastname = splitname[index].to_s.downcase
		begin
			doc = Nokogiri::HTML(open("http://www.osbar.org/members/display.asp?b=#{user.bar_number}"))
			divs = doc.css("table.whiteheader") 
			if (divs.text.include? "Active") && (divs.text.include? user.bar_number.to_s) && (divs.text.downcase.include? lastname)
				divs.css('a.mlink').each do |email|
					if email.text.include? '@'
						emailaddress = email.text
					end
				end
			end
		rescue
			emailaddress = ""
		end

		return emailaddress
	end
end
