require 'neo4j/sane_date_time_converter'

module Neo4j
  module SaneTimestamps
    # This mixin includes a updated_at timestamp property
    module SaneUpdated
      extend ActiveSupport::Concern
      included { property :updated_at, typecaster: SaneDateTimeConverter }
    end
  end
end
