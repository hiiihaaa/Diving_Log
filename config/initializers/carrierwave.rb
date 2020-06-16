require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test? #開発とテストは今まで通りに
    config.storage = :file
  elsif Rails.env.production? #本番はS3に保存する
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],          #credentails.ymlに鍵の本体
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],  #credentails.ymlに鍵の本体
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'divinglog'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/divinglog'
  end
end