require 'net/http'
require "uri"

desc "This task is called by the Heroku cron add-on"
task :call_page => :environment do
   
   uri = URI.parse('https://vizibid-dev.herokuapp.com/')
   
   http = Net::HTTP.new(uri.host, uri.port)
   http.use_ssl = true
   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

   request = Net::HTTP::Get.new(uri.request_uri)
   res = http.request(request)
   
   puts "response code #{res.code}"

 end