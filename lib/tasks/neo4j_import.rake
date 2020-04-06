# this isn't a real seed.rb file so we need to setup the rails env by hand:
require_relative '../../config/environment'
require 'csv'

namespace :neo4j do
  desc "Import data from CSV"
  task :import do
    CSV.foreach(Rails.root.join('db/excerpts.csv'), headers: true) do |row|
      topic = Topic.find_by(name: row[0])
      audience = Audience.find_by(name: row[1])
      author = Author.find_by(name: row[2])
      # TODO: this is almost certainly a mistake... some of these authors'
      #       names are wonky in the CSV but it's fine for now -sd
      Author.create(name: row[2]) unless author

      if row[5] and not row[5].strip.empty?
        Excerpt.create! do |e|
          e.topic = topic
          e.audience = audience
          e.author = author
          e.reference = row[3]
          e.url = row[4]
          e.content = row[5]
        end
      end
    end
  end
end
