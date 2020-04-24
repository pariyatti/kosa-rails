class ForceCreateCardsStackedInspirationCardUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Cards::StackedInspirationCard", :uuid, force: true
  end

  def down
    drop_constraint :"Cards::StackedInspirationCard", :uuid
  end
end
