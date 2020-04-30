class CreateMetadataPerson < Neo4j::Migrations::Base
  def up
    add_constraint :"Metadata::Person", :uuid, force: true
  end

  def down
    drop_constraint :"Metadata::Person", :uuid
  end
end
