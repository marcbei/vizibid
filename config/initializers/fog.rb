CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],       # required
  	:aws_secret_access_key  => ENV['AWS_SECRET_KEY'],       # required
  }
  config.fog_directory  = ENV['AWS_BUCKET']                     # required
  config.fog_host       = 'https://s3.amazonaws.com'            # optional, defaults to nil
  config.fog_public     = false          

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
end