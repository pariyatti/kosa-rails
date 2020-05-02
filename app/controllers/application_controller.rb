# frozen_string_literal: true

# used for top-level views
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login

  def default_url_options
    { host: request.host_with_port }
  end
  
  def index
    # just render some HTML from the view
  end
end
