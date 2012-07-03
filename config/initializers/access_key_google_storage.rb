google_credentials = YAML.load(File.open(Rails.root.join('config', 'google_storage.yml')).read)['google_storage']
GOOGLE_STORAGE_ACCESS_KEY_ID = google_credentials['access_key_id']
GOOGLE_STORAGE_SECRET_ACCESS_KEY = google_credentials['secret_access_key']