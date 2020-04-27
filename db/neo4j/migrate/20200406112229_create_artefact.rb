class CreateArtefact < Neo4j::Migrations::Base
  def up
    add_constraint :Artefact, :uuid, force: true
  end

  def down
    drop_constraint :Artefact, :uuid
  end
end
