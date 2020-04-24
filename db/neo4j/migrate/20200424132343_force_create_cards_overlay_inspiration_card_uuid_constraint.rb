class ForceCreateCardsOverlayInspirationCardUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :"Cards::OverlayInspirationCard", :uuid, force: true
  end

  def down
    drop_constraint :"Cards::OverlayInspirationCard", :uuid
  end
end
