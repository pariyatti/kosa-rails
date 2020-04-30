class CreateMetadataTopic < Neo4j::Migrations::Base
  def up
    add_constraint :"Metadata::Topic", :uuid, force: true
  end

  def down
    drop_constraint :"Metadata::Topic", :uuid
  end
end
