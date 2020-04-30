class CreateMetadataAuthor < Neo4j::Migrations::Base
  def up
    add_constraint :"Metadata::Author", :uuid, force: true
  end

  def down
    drop_constraint :"Metadata::Author", :uuid
  end
end
