class CreateArtefactsVideo < Neo4j::Migrations::Base
  def up
    add_constraint :"Artefacts::Video", :uuid, force: true
  end

  def down
    drop_constraint :"Artefacts::Video", :uuid
  end
end
