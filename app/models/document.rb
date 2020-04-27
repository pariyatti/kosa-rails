
# top-level type in Artefact hierarchy for all text-based content
class Document < Artefact
  include Neo4j::ActiveNode

end
