class Cards::PaliWordCard < Card
  has_many :in, :translations, origin: :pali_word_card, model_class: :"Cards::PaliWordTranslation"
  property :pali, type: String, default: ""

  property :audio, type: String
  mount_uploader :audio, AudioUploader

  def self.default_header
    "Pāli Word of the Day"
  end

  # TODO: HACK: this is just for temporary display in the edit
  #             screen until we can display translation lists. -sd
  def language
    translations[0].language
  end

  def translation
    translations[0].translation
  end

  def self.new_from_params(params)
    # TODO: HACK: this is just to get the screen and API working
    #             ...figure out lists. -sd
    translation_params = params.slice(:language, :translation)
    @translation = Cards::PaliWordTranslation.create(translation_params)

    new_card_params = params.except(:language).except(:translation)
    card = new_with_audio(default_params(new_card_params))

    card.translations = [@translation]
    card
  end

  def as_json(options)
    serializable_hash(include: :translations).as_json
  end

end
