S3DirectUpload.config do |c|
  c.access_key_id = ENV['AWS_ACCESS_KEY']       # "AKIAJM7PGSDYBRC76SFQ"
  c.secret_access_key = ENV['AWS_SECRET_KEY']  # your secret access key
  c.bucket = ENV['AWS_BUCKET']               # your bucket name
end
