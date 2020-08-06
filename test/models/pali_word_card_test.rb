require 'test_helper'

class PaliWordCardTest < ActiveSupport::TestCase
  test "pali word cards should expose one language and one translation" do
    c = Cards::PaliWordCard.new_from_params(card_type: "pali_word", 
      pali: "cetasā", language: "en", translation: "of the mind")
    c.save!

    assert_equal "of the mind", c.translation
    assert_equal "en", c.language
  end
end
