require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup = Card.where(image: "controller_test.jpg")
    cleanup.each { |c| c.destroy }
    @card = Card.new(shareable: "true", image: "controller_test.jpg", bookmarkable: "true", text: "zzz", type: "inspiration")
  end

  test "create a card with a card_type param" do
    assert_difference('Card.count') do
      post cards_url, params: { card: { bookmarkable: @card.bookmarkable, 
        flag: @card.flag, 
        header: @card.header, 
        image: @card.image, 
        shareable: @card.shareable, 
        text: @card.text, 
        title: @card.title, 
        card_type: @card.type } }
    end

    assert_redirected_to card_url(Card.find_by(image: "controller_test.jpg"))
  end
end
