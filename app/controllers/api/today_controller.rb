# frozen_string_literal: true

# API to the "Today" tab in the app
class Api::TodayController < ActionController::Base
  def index
    respond_to do |format|
      format.json { render json: Card.today_feed }
     end
  end
end
