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
    # pretty_json(expected_response, response.body)
    assert_json(expected_response, response.body, 
                **{ignore: ['image', 'flag', 'title', 'header', 'id']})
  end

  def cleanup
    # cards = Card.where(text: /today_controller_test.*/i)
    Card.all.each { |c| c.destroy }
  end
end
