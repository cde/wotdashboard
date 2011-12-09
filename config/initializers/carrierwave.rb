unless Kernel.const_defined?("S3_CONFIG")
  S3_CONFIG = YAML.load_file("#{Rails.root}/config/fog_credentials.yml")[Rails.env].try(:symbolize_keys)
end
#Heroku has a read-only filesystem, so uploads must be stored on S3 and cannot be cached in the public directory.
#Until we set S3 we're gonna set cache_dir
CarrierWave.configure do |config|
  #config.root = Rails.root.join('tmp')
  #config.cache_dir = "uploads"
  config.fog_credentials = {
    :provider               => S3_CONFIG[:provider], #'AWS',       # required
    :aws_access_key_id      => S3_CONFIG[:aws_access_key_id], #'AKIAIT47VZNUWYIXSPSA',       # required
    :aws_secret_access_key  => S3_CONFIG[:aws_secret_access_key] #'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'       # required
  }
  config.fog_directory  = 'wotdashboard'                     # required
  #config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
  config.fog_public     = false                                   # optional, defaults to true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
