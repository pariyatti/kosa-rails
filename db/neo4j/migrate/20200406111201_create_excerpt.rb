class CreateExcerpt < Neo4j::Migrations::Base
  def up
    add_constraint :Excerpt, :uuid, force: true
  end

  def down
    drop_constraint :Excerpt, :uuid
  end
end
