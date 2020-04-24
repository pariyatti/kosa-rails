# this class MUST be restricted to the Cards:: namespace because Cards are
# not permitted to have relationships with non-card models
class Cards::PaliWordTranslation
  include Neo4j::ActiveNode

  has_one :out, :pali_word_card, type: :pali_word_card

  property :language, type: String, default: ""
  property :translation, type: String, default: ""

end
