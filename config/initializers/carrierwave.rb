CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    :provider               => 'Google',
    :google_storage_access_key_id     => 'GOOGOQ4G733INVQFV5QF',
    :google_storage_secret_access_key  => 'VkDdu9jMeNx4Ea+9e2sCviAZPWeFsYFBEeQu7m6W'
  }
  config.fog_directory  = "constrvct_#{Rails.env}"
end