
Clearance.configure do |config|
  config.routes = false
  config.allow_sign_up = false
  # this is necessary to permit cookies in multiple domains 
  # such as development (localhost or lvh.me), sandbox, and production:
  config.cookie_domain = lambda { |request| request.host }
  config.cookie_name = "remember_kosa_admin_token"
  config.httponly = false
  config.mailer_sender = "webmaster@pariyatti.com"
  config.rotate_csrf_on_sign_in = true
end
