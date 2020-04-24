require_relative '../../config/environment'
include Neo4j::Migrations::Helpers

namespace :neo4j do
  namespace :db do

    desc "Open a Cypher console"
    task :console do
      sh "cypher-shell -a #{Rails.application.config.neo4j.session_path}"
    end

    desc "Run Neo4j Desktop"
    task :desktop do
      script = "./bin/neo4j-desktop"
      if File.file?(script)
        sh(script)
      else
        puts "Download neo4j Desktop, put it in kosa/bin and symlink to `kosa/bin/neo4j-desktop`."
      end
    end

    desc "Drop the database"
    task :drop do
        execute("match (n) detach delete n;")
        execute("call db.constraints").each do |constraint|
          execute "drop #{constraint[:description]}"
        end
        execute("call db.indexes").each do |index|
          execute "drop #{index[:description]}"
        end
    end

    desc "Migrate the database (wrapper)"
    task :migrate do
      sh "bundle exec rake neo4j:migrate"
    end

    desc "Initialize a new database"
    task :setup => [:migrate, :seed]

    desc "Initialize sample data"
    task :sample => [:sandbox, :import]

    desc "Drop and recreate the database"
    task :reset => [:drop, :setup]
  end
end
