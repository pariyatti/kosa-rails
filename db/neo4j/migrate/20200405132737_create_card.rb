class CreateCard < Neo4j::Migrations::Base
  def up
    add_constraint :Card, :uuid, force: true
    add_index :Card, :type, force: true
  end

  def down
    drop_constraint :Card, :uuid
    drop_index :Card, :type
  end
end
