class CreateMetadataCollection < Neo4j::Migrations::Base
  def up
    add_constraint :"Metadata::Collection", :uuid, force: true
  end

  def down
    drop_constraint :"Metadata::Collection", :uuid
  end
end
