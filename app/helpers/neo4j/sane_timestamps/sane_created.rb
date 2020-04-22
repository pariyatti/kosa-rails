require 'neo4j/sane_date_time_converter'

module Neo4j
  module SaneTimestamps
    # This mixin includes a created_at timestamp property
    module SaneCreated
      extend ActiveSupport::Concern
      included { property :created_at, typecaster: SaneDateTimeConverter }
    end
  end
end
