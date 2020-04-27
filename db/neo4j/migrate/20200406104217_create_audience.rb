class CreateAudience < Neo4j::Migrations::Base
  def up
    add_constraint :Audience, :uuid, force: true
  end

  def down
    drop_constraint :Audience, :uuid
  end
end
