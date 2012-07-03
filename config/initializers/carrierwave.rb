CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    :provider               => 'Google',
    :google_storage_access_key_id     => GOOGLE_STORAGE_ACCESS_KEY_ID,
    :google_storage_secret_access_key  => GOOGLE_STORAGE_SECRET_ACCESS_KEY
  }
  config.fog_directory  = "constrvct_#{Rails.env}"
end