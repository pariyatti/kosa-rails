class ForceCreateCardTypeIndex < Neo4j::Migrations::Base
  def up
    add_index :Card, :type, force: true
  end

  def down
    drop_index :Card, :type
  end
end
