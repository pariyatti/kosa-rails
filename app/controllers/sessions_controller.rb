class SessionsController < Clearance::SessionsController

  # this is required because Clearance::SessionsController
  # assumes it exists
  def sign_in_url
    login_url
  end

end
