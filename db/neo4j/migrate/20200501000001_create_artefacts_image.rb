class CreateArtefactsImage < Neo4j::Migrations::Base
  def up
    add_constraint :"Artefacts::Image", :uuid, force: true
  end

  def down
    drop_constraint :"Artefacts::Image", :uuid
  end
end
