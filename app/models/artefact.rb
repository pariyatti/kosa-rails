
# top-level type in the hierarchy; don't create these directly
class Artefact
  include Neo4j::ActiveNode
  include Neo4j::SaneTimestamps

  # property :name, type: String
end
