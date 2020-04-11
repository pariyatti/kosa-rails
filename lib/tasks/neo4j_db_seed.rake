# this isn't a real seed.rb file so we need to setup the rails env by hand:
require_relative '../../config/environment'

namespace :neo4j do
  namespace :db do
    desc "Add seed data"
    task :seed do
      puts "Seeding default Audiences..."
      AUDIENCES = [ "Old Students",
        "Old Students Struggling to Practice", 
        "Teenagers",
        "New Students",
        "Mothers",
        "Parents",
        "Unwell" ]
      AUDIENCES.each do |name|
        Audience.create(name: name) if Audience.find_by(name: name).nil?
      end

      puts "Seeding default Topics..."
      TOPICS = [ "Anger",
        "Daily Practice",
        "Lust",
        "Fear",
        "Anxiety",
        "Joy",
        "Compassion",
        "Mental Health",
        "Kamma (Karma)" ]
      TOPICS.each do |name|
        Topic.create(name: name) if Topic.find_by(name: name).nil?
      end
    end
  end
end
