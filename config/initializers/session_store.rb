# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_projectmanager-new_session',
  :secret      => '2dfcb311b2c47d077a0142c34d874d94960a3c9f01a825df0fb016a1e0ec18a0e4749b3714eec11145a5f426bfd674b37ff535aa1bbd14598443bd1d38874179'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
