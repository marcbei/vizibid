CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],       # required
  	:aws_secret_access_key  => ENV['AWS_SECRET_KEY'],       # required
  }
  config.storage = :fog
  config.fog_directory  = ENV['AWS_BUCKET']                     
  config.fog_public     = false 
  config.cache_dir = "#{Rails.root}/tmp/uploads"            
end