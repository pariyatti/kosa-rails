# this isn't a real seed.rb file so we need to setup the rails env by hand:
require_relative '../../config/environment'

namespace :neo4j do
  namespace :db do
    desc "Create some sample data for the sandbox environment"
    task :sandbox do
      img_files = Dir.glob(Rails.root.join('lib/tasks/sandbox/*'))

      puts "Creating some Images..."
      img_files.each do |img|
        i = ImageAsset.new()
        i.image = File.open(img)
        i.save!
      end
      
      puts "Creating some Stacked Inspiration Cards..."
      params = {published: true, 
        shareable: true, 
        bookmarkable: true,
        text: "Blue skiiiieeeeesssssss smiling at meeeeeeeeee. ",
        card_type: "stacked_inspiration" }
      card = Cards::StackedInspirationCard.new_from_params(params)
      card.image = File.open(img_files[0])
      card.save!

      params = {published: true, 
        shareable: true, 
        bookmarkable: true,
        text: " Enjoy some beautiful red flowers on the ground did you know you can also turn them into jam but you have to dry them on your rootop first which maybe you don't have the time for and you'd rather buy jam from a store.",
        card_type: "stacked_inspiration" }
      card = Cards::StackedInspirationCard.new_from_params(params)
      card.image = File.open(img_files[1])
      card.save!

      puts "Creating some Overlay Inspiration Cards..."
      params = {published: true, 
        shareable: true, 
        bookmarkable: true,
        text: "This card has a Peepal leaf on it because if there's one thing we know about meditation it's that it involves a lot of Peepal leaves, right?",
        text_color: "yellow",
        card_type: "overlay_inspiration" }
      card = Cards::OverlayInspirationCard.new_from_params(params)
      card.image = File.open(img_files[2])
      card.save!

    end
  end
end
