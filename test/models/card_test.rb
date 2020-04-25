require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test "transforms raw parameters into enums" do
    c = Cards::StackedInspirationCard.new_from_params(card_type: "stacked_inspiration")
    assert_equal 4, c.type
  end

  test "cannot create a Card directly" do
    assert_raises RuntimeError, "No `new_from_params` method defined." do
       Card.new_from_params(card_type: "zig")
    end
  end

  test "cannot create `with_image` directly" do
    assert_raises NoMethodError do
       Cards::StackedInspirationCard.new_with_image(image: "some.png")
    end
  end

  test "cannot create a card with an invalid enum" do
    assert_raises Neo4j::Shared::Enum::InvalidEnumValueError do
      Cards::StackedInspirationCard.create(text: "invalid", type: "invalid_enum")
    end
  end

  test "publishes and unpublishes (drafts) a card" do
    c = Cards::PaliWordCard.new_from_params(card_type: "pali_word")
    assert_nil c.published_at
    c.publish!
    assert_not_nil c.published_at
    c.draft!
    assert_nil c.published_at
  end
end
