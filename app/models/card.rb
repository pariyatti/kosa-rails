class Card 
  include Neo4j::ActiveNode
  property :type, type: String
  property :flag, type: String
  property :bookmarkable, type: String
  property :shareable, type: String
  property :title, type: String
  property :header, type: String
  property :image, type: String
  property :text, type: String



end
