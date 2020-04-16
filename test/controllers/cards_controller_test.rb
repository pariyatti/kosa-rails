require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup = Card.where(text: "controller_test")
    cleanup.each { |c| c.destroy }
    @card = Card.new(text: "controller_test", shareable: "true", bookmarkable: "true", type: "inspiration")
  end

  test "create a card with a card_type param" do
    assert_difference('Card.count') do
      post cards_url, params: { card: { bookmarkable: @card.bookmarkable, 
        flag: @card.flag, 
        header: @card.header, 
        image_filename: file_fixture("card_fixture.png").to_s,
        shareable: @card.shareable, 
        text: @card.text, 
        title: @card.title, 
        card_type: @card.type } }
    end

    assert_redirected_to card_url(Card.find_by(text: "controller_test"))
  end

  # TODO: yet another feature we only get with ActiveRecord -sd
  def file_fixture(filename)
    Rails.root.join("test/fixtures/files", filename)
  end
end
