# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :require_login
  layout 'settings'

  def index
  end
end
