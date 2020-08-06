
module TestHelpers
  module Stubs
    def stub_user
      u = User.new
      u.email = "stub@test.org"
      u.password = "stub"
      u.admin = true
      u.reset_remember_token!
      u.save!
      u
    end
  end
end
