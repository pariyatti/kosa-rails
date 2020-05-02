class CreateUser < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint :User, :uuid, force: true
    u = User.new
    u.email = "kosa@pariyatti.org"
    u.password = "kosa"
    u.admin = true
    u.reset_remember_token!
    u.save!
  end

  def down
    drop_constraint :User, :uuid
  end
end
