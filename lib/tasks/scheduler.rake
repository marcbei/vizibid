require 'net/http'

desc "This task is called by the Heroku cron add-on"
task :call_page => :environment do
   uri = URI.parse('https://vizibid-dev.herokuapp.com/')
   res = Net::HTTP.get_response(uri)
   puts "response code #{res.code}"
 end