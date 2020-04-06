class CreateExcerpt < Neo4j::Migrations::Base
  def up
    add_constraint :Excerpt, :uuid
  end

  def down
    drop_constraint :Excerpt, :uuid
  end
end
