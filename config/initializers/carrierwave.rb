# unless Rails.env.development? || Rails.env.test?
#   CarrierWave.configure do |config|
#     config.storage :fog
#     config.fog_provider = 'fog/aws'
#     config.fog_directory  = 'tabi-share'
#     config.fog_authenticated_url_expiration = 60
#     # config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/tabi-share'
#     config.fog_public = false
#     config.fog_credentials = {
#       provider: 'AWS',
#       aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#       aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
#       region: 'ap-northeast-1'
#     }

#     config.fog_directory  = 'rails-photo-123'
#     config.cache_storage = :fog
#   end
# end

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'tabi-share'
  config.asset_host = 'https://tabi-share.s3.amazonaws.com'
  config.cache_storage = :fog
  config.fog_provider = 'fog/aws'
end