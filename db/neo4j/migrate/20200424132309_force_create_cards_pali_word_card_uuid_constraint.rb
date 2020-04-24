class ForceCreateCardsPaliWordCardUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Cards::PaliWordCard", :uuid, force: true
  end

  def down
    drop_constraint :"Cards::PaliWordCard", :uuid
  end
end
