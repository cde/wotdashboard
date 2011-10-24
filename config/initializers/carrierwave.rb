#Heroku has a read-only filesystem, so uploads must be stored on S3 and cannot be cached in the public directory.
#Until we set S3 we're gonna set cache_dir'
CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrierwave'
end
