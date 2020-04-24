require 'neo4j/sane_timestamps'

class Card 
  include Neo4j::ActiveNode
  include Neo4j::SaneTimestamps
  property :published, type: Boolean, default: false
  property :header, type: String, default: ""
  property :bookmarkable, type: Boolean, default: true
  property :shareable, type: Boolean, default: true

  
#  property :flag, type: String
#  property :title, type: String 
#  property :text, type: String

  enum type: [:generic,
              :words_of_the_buddha,
              :pali_word, 
              :doha, 
              :stacked_inspiration, 
              :overlay_inspiration,
              :topic_of_the_week, 
              :donation, 
              :pilgrimage, 
              :recommended_read], _default: :generic, _suffix: true

  def reload_from_database!
    # ignored for Cards without file attachments like images
  end

  def self.default_header
    raise "No `default_header` method defined."
  end

  def self.default_params(params)
    int_type = Card.types[params[:card_type].to_sym]
    params.merge(type: int_type, header: default_header).except(:card_type)
  end

  def self.new_from_params(params)
    raise "No `new_from_params` method defined."
  end

  # Please forgive the inheritance trickery. This seems better than the 
  # alternative of duplicating this method across all Cards that need images.
  def self.new_with_image(params)
    card = new(params.except(:image_filename))
    card.image = File.new(params[:image_filename]) if params[:image_filename]
    card
  end

  class << self
    protected :new_with_image
  end
end
