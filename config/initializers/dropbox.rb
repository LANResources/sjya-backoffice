DROPBOX_CONFIG = YAML.load(File.read(File.expand_path('../../dropbox.yml', __FILE__)))
DROPBOX_CONFIG.merge! DROPBOX_CONFIG.fetch(Rails.env, {})
DROPBOX_CONFIG[:subfolder] = Rails.env == 'staging' ? 'production' : Rails.env
DROPBOX_CONFIG.symbolize_keys!
