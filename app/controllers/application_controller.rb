# frozen_string_literal: true

# used for top-level views
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login
  
  def index
    # just render some HTML from the view
  end
end
