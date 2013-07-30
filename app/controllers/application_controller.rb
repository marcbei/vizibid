class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper

  def IsNilOrEmpty(value)
 	value.nil? || value.empty?
  end

end
