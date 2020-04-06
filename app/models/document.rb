
# top-level type in Asset hierarchy for all text-based content
class Document < Asset
  include Neo4j::ActiveNode

end
