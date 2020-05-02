ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'helpers/json_utilities'
require 'helpers/stubs'

class ActiveSupport::TestCase
  include JsonUtilities
  include Stubs

  # Neo4j transactions don't behave like relational db transactions, so
  # we can't parallelize without breaking some controller tests.
  parallelize(workers: 1)
  # parallelize(workers: :number_of_processors)

  # NOTE: normally we'd get this for free, but it's actually a part of 
  #       ActiveRecord for some reason
  def file_fixture(filename)
    Rails.root.join("test/fixtures/files", filename)
  end
end
