# frozen_string_literal: true

# API to the "Today" tab in the app
class Api::TodayController < ActionController::Base
  def index
    cards = Card.where(published: true)
    cards.each(&:reload_from_database!)
    today = {today_cards: cards}
    
    respond_to do |format|
      format.json { render json: today }
     end
  end
end
