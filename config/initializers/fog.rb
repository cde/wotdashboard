CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIT47VZNUWYIXSPSA',       # required
    :aws_secret_access_key  => '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'       # required
  }
  config.fog_directory  = 'wotdashboard'                     # required
  #config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
  #config.fog_public     = false                                   # optional, defaults to true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
