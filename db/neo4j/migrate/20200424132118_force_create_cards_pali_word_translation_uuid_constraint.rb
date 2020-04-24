class ForceCreateCardsPaliWordTranslationUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Cards::PaliWordTranslation", :uuid, force: true
  end

  def down
    drop_constraint :"Cards::PaliWordTranslation", :uuid
  end
end
