# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_quintophoto_session',
  :secret      => 'fa464c36dd24d86a8b4fb5c27fb53c7307c84e21cf5a472f3afd327391bce37923fbc09824151589241705b68aee2baad26e8952e7758a6b520bcb79c2a2ac24'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
