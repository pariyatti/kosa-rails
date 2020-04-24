require 'test_helper'

class TodayControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup
    3.times do |i|
      params = {published: true, 
                shareable: true, 
                bookmarkable: true,
                text: "today_controller_test_stacked#{i}",
                card_type: "stacked_inspiration" }
      card = Cards::StackedInspirationCard.new_from_params(params)
      card.image = File.open(file_fixture("card_fixture.png"))
      card.save!
    end
    params = {published: true, 
              shareable: true, 
              bookmarkable: true,
              text: "today_controller_test_overlay",
              text_color: "green",
              card_type: "overlay_inspiration" }
    card = Cards::OverlayInspirationCard.new_from_params(params)
    card.image = File.open(file_fixture("card_fixture.png"))
    card.save!
  end

  teardown do
    cleanup
  end

  test "get the today feed: use `VERBOSE=true rake test` to see json" do
    get today_url, as: :json
    expected_response = file_fixture("today_fixture.json").read
    pretty_json(expected_response, response.body) if ENV['VERBOSE']
    assert_json(expected_response, response.body, 
                **{ignore: ['nope', 'image', 'id']})
  end

  def cleanup
    Card.all.each { |c| c.destroy }
  end
end
