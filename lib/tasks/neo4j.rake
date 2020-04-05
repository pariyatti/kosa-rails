require 'neo4j/rake_tasks'

namespace :neo4j do
  desc "Run Neo4j Desktop"
  task :desktop do
    script = "./bin/neo4j-desktop"
    if File.file?(script)
      sh(script)
    else
      puts "Download neo4j Desktop, put it in kosa/bin and symlink to `kosa/bin/neo4j-desktop`."
    end
  end
end
