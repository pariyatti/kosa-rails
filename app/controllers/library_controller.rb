# frozen_string_literal: true

class LibraryController < ApplicationController
  before_action :require_login
  layout 'library'

  def index
  end
end
