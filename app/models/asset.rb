
# top-level type in the hierarchy; don't create these directly
class Asset 
  include Neo4j::ActiveNode
  # include Neo4j::Timestamps

  # property :name, type: String
end
