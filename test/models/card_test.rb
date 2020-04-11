require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test "transforms raw parameters into enums" do
    c = Card.from_params(card_type: "inspiration")
    assert_equal 4, c.type
  end
end
