class CreateArtefactsExcerpt < Neo4j::Migrations::Base
  def up
    add_constraint :"Artefacts::Excerpt", :uuid, force: true
  end

  def down
    drop_constraint :"Artefacts::Excerpt", :uuid
  end
end
