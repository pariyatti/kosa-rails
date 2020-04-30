class CreateArtefactsAudio < Neo4j::Migrations::Base
  def up
    add_constraint :"Artefacts::Audio", :uuid, force: true
  end

  def down
    drop_constraint :"Artefacts::Audio", :uuid
  end
end
