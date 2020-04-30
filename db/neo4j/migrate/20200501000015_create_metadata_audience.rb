class CreateMetadataAudience < Neo4j::Migrations::Base
  def up
    add_constraint :"Metadata::Audience", :uuid, force: true
  end

  def down
    drop_constraint :"Metadata::Audience", :uuid
  end
end
