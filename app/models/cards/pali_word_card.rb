class Cards::PaliWordCard < Card
  has_many :in, :pali_word_translations, origin: :pali_word_card, model_class: :"Cards::PaliWordTranslation"
  property :pali, type: String, default: ""

  def self.default_header
    "Pāli Word of the Day"
  end

  def self.new_from_params(params)
    new(default_params(params))
  end
end
