require 'neo4j/sane_timestamps'
require 'neo4j/sane_date_time_converter'

class Card 
  include Neo4j::ActiveNode
  include Neo4j::SaneTimestamps
  property :published_at, typecaster: Neo4j::SaneDateTimeConverter, default: nil
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

  def publish!
    self.published_at = Time.now
    self.save!
  end

  def draft!
    self.published_at = nil
    self.save!
  end

  def self.today_feed
    cards = Card.where_not(published_at: nil).order(:updated_at)
    cards.each(&:reload_from_database!)
    cards.to_a.reverse
  end

  def self.all_for_editors(type=nil)
    cards = type ? Card.where(type: Card.types[type]) : Card.all
    cards = cards.order(:updated_at)
    cards.each(&:reload_from_database!)
    cards.to_a.reverse
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

  def self.new_with_image(params)
    card = new(params.except(:image_filename))
    card.image = File.new(params[:image_filename]) if params[:image_filename]
    card
  end

  def self.new_with_audio(params)
    card = new(params.except(:audio_filename))
    card.audio = File.new(params[:audio_filename]) if params[:audio_filename]
    card
  end

  # Please forgive the inheritance trickery. This seems better than the 
  # alternative of duplicating this method across all Cards that need images.
  class << self
    protected :new_with_image
    protected :new_with_audio
  end
end
