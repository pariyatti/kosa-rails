# frozen_string_literal: true

# API to the "Today" tab in the app
class Api::TodayController < ActionController::Base
  def index
    cards = Card.where(published: true).order(:updated_at)
    cards.each(&:reload_from_database!)
    
    respond_to do |format|
      format.json { render json: cards }
     end
  end
end
