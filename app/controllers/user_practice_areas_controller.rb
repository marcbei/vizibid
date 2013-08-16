class UserPracticeAreasController < ApplicationController
	
 	before_filter :signed_in_user

 	def update

 		practice_areas.each do |p|
 			up = UserPracticeArea.find(:all, :conditions => ["user_id = '#{current_user.id}' and practice_area_id = '#{p[1]}'"])
 			if params[p[0].to_sym] == "selected" && up.count != 1
 				UserPracticeArea.new(:user_id => current_user.id, :practice_area_id => p[1]).save
 			elsif params[p[0].to_sym] != "selected" && up.count == 1
 				up[0].delete
 			end
 		end

 		# fix to redirect to subscriptions tab
 		redirect_to root_path
 	end

end