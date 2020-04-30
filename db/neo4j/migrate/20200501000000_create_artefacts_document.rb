class CreateArtefactsDocument < Neo4j::Migrations::Base
  def up
    add_constraint :"Artefacts::Document", :uuid, force: true
  end

  def down
    drop_constraint :"Artefacts::Document", :uuid
  end
end
