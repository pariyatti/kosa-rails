require 'test_helper'

class TodayControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup
    3.times do |i|
      params = {published: true, 
                shareable: true, 
                bookmarkable: true,
                text: "today_controller_test#{i}",
                card_type: "stacked_inspiration" }
      card = Cards::StackedInspirationCard.new_from_params(params)
      card.image = File.open(file_fixture("card_fixture.png"))
      card.save!
    end
  end

  teardown do
    cleanup
  end

  test "get the today feed" do
    get today_url, as: :json
    expected_response = file_fixture("today_fixture.json").read
    # pretty_json(expected_response, response.body)
    assert_json(expected_response, response.body, 
                **{ignore: ['image', 'id']})
  end

  def cleanup
    # cards = Card.where(text: /today_controller_test.*/i)
    Card.all.each { |c| c.destroy }
  end
end
