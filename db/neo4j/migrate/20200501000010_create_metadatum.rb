class CreateMetadatum < Neo4j::Migrations::Base
  def up
    add_constraint :Metadatum, :uuid, force: true
  end

  def down
    drop_constraint :Metadatum, :uuid
  end
end
