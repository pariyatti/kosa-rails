class CreateMetadataLanguage < Neo4j::Migrations::Base
  def up
    add_constraint :"Metadata::Language", :uuid, force: true
  end

  def down
    drop_constraint :"Metadata::Language", :uuid
  end
end
