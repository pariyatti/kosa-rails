# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

puts "Toggling $VERBOSE=nil (silence) in Rakefile."
$VERBOSE = nil

require_relative 'config/application'

Rails.application.load_tasks
