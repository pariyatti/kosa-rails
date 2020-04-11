class Card 
  include Neo4j::ActiveNode
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
              :inspiration, 
              :topic_of_the_week, 
              :donation, 
              :pilgrimage, 
              :recommended_read], _default: :generic, _suffix: true

  def self.from_params(params)
    int_type = Card.types[params[:card_type].to_sym]
    Card.new(params.merge(type: int_type).except(:card_type))
  end
end
