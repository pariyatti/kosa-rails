require 'test_helper'

class TodayControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup
    3.times do |i|
      params = {published_at: Time.parse("2020-04-25 18:26:30.774998000 UTC"),
                shareable: true, 
                bookmarkable: true,
                text: "today_controller_test_stacked#{i}",
                card_type: "stacked_inspiration" }
      card = Cards::StackedInspirationCard.new_from_params(params)
      card.image = File.open(file_fixture("card_fixture.png"))
      card.save
    end
    
    params = {published_at: Time.parse("2020-04-25 18:26:30.774998000 UTC"), 
              shareable: true, 
              bookmarkable: true,
              text: "today_controller_test_overlay",
              text_color: "green",
              card_type: "overlay_inspiration" }
    card = Cards::OverlayInspirationCard.new_from_params(params)
    card.image = File.open(file_fixture("card_fixture.png"))
    card.save!

    params = {published_at: Time.parse("2020-04-25 18:26:30.774998000 UTC"), 
              shareable: true, 
              bookmarkable: true,
              pali: "vipassisuṃ controller test",
              language: "en",
              translation: "insight controller test",
              card_type: "pali_word" }
    card = Cards::PaliWordCard.new_from_params(params)
    card.audio = File.open(file_fixture("vipassisu.m_audio_fixture.mp3"))
    card.save!
  end

  teardown do
    cleanup
  end

  test "[SMOKE TEST] get the today feed: use `VERBOSE=true rake test` to see json" do
    get today_url, as: :json
    expected_response = file_fixture("today_fixture.json").read
    pretty_json(expected_response, response.body) if ENV['VERBOSE']
    assert_json(expected_response, response.body, 
                **{ignore: ['image', 'audio', 'id']})
  end

  def cleanup
    Card.all.each { |c| c.destroy }
  end
end
