require 'neo4j/sane_timestamps/sane_created'
require 'neo4j/sane_timestamps/sane_updated'

module Neo4j
  # This mixin includes timestamps in the included class
  # The `Sane` part is a fix for the lack of millisecond resolution
  # in the default library.
  module SaneTimestamps
    extend ActiveSupport::Concern
    include SaneCreated
    include SaneUpdated
  end
end
