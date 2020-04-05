class CreateCard < Neo4j::Migrations::Base
  def up
    add_constraint :Card, :uuid
  end

  def down
    drop_constraint :Card, :uuid
  end
end
