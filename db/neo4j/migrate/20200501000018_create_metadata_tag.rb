class CreateMetadataTag < Neo4j::Migrations::Base
  def up
    add_constraint :"Metadata::Tag", :uuid, force: true
  end

  def down
    drop_constraint :"Metadata::Tag", :uuid
  end
end
