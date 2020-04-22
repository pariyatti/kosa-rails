require 'test_helper'

class TodayControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup
    3.times do |i|
      card = Card.create(text: "today_controller_test#{i}", published: true, shareable: true, bookmarkable: true, type: "inspiration")
      card.image = File.open(file_fixture("card_fixture.png"))
      card.save!
      #sleep(1) # yes, really... commits can come out of order
    end
  end

  teardown do
    cleanup
  end

  test "get the today feed" do
    get today_url, as: :json

    expected_response = file_fixture("today_fixture.json").read
    # TODO: move the pretty json into the debug method
    debug_json(JSON.pretty_generate(JSON.parse(expected_response)), 
               JSON.pretty_generate(JSON.parse(response.body)))

    assert compare_json(expected_response, response.body, 
                        **{ignore: ['image', 'flag', 'title', 'header', 'id']})
  end

  def cleanup
    cards = Card.where(text: /today_controller_test.*/i)
    cards.each { |c| c.destroy }
  end
end
