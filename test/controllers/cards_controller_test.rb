require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup
    @card = Cards::StackedInspirationCard.new(text: "cards_controller_test", shareable: "true", bookmarkable: "true", type: "stacked_inspiration")
  end

  teardown do
    cleanup
  end

  test "create a card with a card_type param" do
    assert_difference('Card.count') do
      post cards_stacked_inspiration_cards_url, 
        params: { cards_stacked_inspiration_card: { 
          card_type: @card.type,
          bookmarkable: @card.bookmarkable, 
          shareable: @card.shareable,
          header: @card.header, 
          image_filename: file_fixture("card_fixture.png").to_s,
          text: @card.text 
        } }
    end

    assert_redirected_to cards_stacked_inspiration_card_url(Card.find_by(text: "cards_controller_test"))
  end

  def cleanup 
    cards = Card.where(text: "cards_controller_test")
    cards.each { |c| c.destroy }
  end
end
