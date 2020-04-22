require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup
    @card = Card.new(text: "cards_controller_test", shareable: "true", bookmarkable: "true", type: "inspiration")
  end

  teardown do
    cleanup
  end

  test "create a card with a card_type param" do
    assert_difference('Card.count') do
      post cards_url, params: { card: { 
        bookmarkable: @card.bookmarkable, 
        flag: @card.flag, 
        header: @card.header, 
        image_filename: file_fixture("card_fixture.png").to_s,
        shareable: @card.shareable, 
        text: @card.text, 
        title: @card.title, 
        card_type: @card.type } }
    end

    assert_redirected_to card_url(Card.find_by(text: "cards_controller_test"))
  end

  def cleanup 
    cards = Card.where(text: "cards_controller_test")
    cards.each { |c| c.destroy }
  end
end
