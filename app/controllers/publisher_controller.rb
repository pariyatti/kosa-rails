# frozen_string_literal: true

class PublisherController < ApplicationController
  before_action :require_login
  layout 'publisher'

  def index
  end
end
