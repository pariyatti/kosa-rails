class CreateMetadataLocation < Neo4j::Migrations::Base
  def up
    add_constraint :"Metadata::Location", :uuid, force: true
  end

  def down
    drop_constraint :"Metadata::Location", :uuid
  end
end
