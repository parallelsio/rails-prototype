# http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region
# https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Make-Carrierwave-work-on-Heroku

CarrierWave.configure do |config|
    config.fog_credentials = {
        provider:              	'AWS',
        aws_access_key_id:     	ENV["AWS_ACCESS_KEY_ID"],
        aws_secret_access_key: 	ENV["AWS_SECRET_ACCESS_KEY"],
        region:                	ENV["AWS_S3_BUCKET_REGION"]
   }

    config.fog_directory = ENV["AWS_S3_BUCKET"]
    config.fog_public    = true
    config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' } 

    # config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
end