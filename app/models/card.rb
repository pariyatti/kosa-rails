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

  enum type: [:generic,
              :words_of_the_buddha,
              :pali_word_of_the_day, 
              :doha, 
              :inspriation, 
              :topic_of_the_week, 
              :donation, 
              :pilgrimage, 
              :recommended_read]

end
