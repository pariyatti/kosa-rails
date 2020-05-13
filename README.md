# kosa [m.]: _store-room; treasury_

Kosa is a library, editorial, and publishing service.

## Design Wireframes

- [Publisher](https://whimsical.com/4tTbGHDiYkYXj7cUnTBSTb)
- [Library](https://whimsical.com/6LN2LDkv1bRyyuojyiJ8oV)

## Architectural Thinking

- [The Pariyatti Data Model](https://github.com/pariyatti/agga/blob/master/docs/data-models.pdf)
- [What is a (relational) database?](https://docs.google.com/document/d/1QuiWPaAUH9_UOeBouGGCgF_FyRRhoL4uLkfKvSsbw2o/edit#)
- [What is a graph database?](https://neo4j.com/developer/graph-database/)

## Mobile App API

The Pariyatti mobile app will consume the API as specified [here](https://github.com/pariyatti/kosa/blob/master/docs/api.md).

### Option 1: Use the Sandbox server

[http://kosa-sandbox.pariyatti.org](http://kosa-sandbox.pariyatti.org) - Use this option if you will working exclusively on the mobile app without modifying or debugging the server.

### Option 2: Set up a local development server

Follow the instructions under [Development](https://github.com/pariyatti/kosa#development). Use this option if you need to modify or debug the server itself.

## Deployment

Deployment instructions: [`/deployment/README.md`](https://github.com/pariyatti/kosa/blob/master/deployment/README.md)

## Development

In general, pin versions in development the way you would in any other environment.

There is a lot of old `Neo4j.rb` documentation out there. Use these:

- https://neo4jrb.readthedocs.io/en/v9.4.0/
- https://gitter.im/neo4jrb/neo4j (look for @klobuczek and @amitTheSongadya_twitter)
- https://neo4j.com/developer/ruby/

### Linux Dev Setup (Ubuntu 19.10)

#### Install Ruby

```
sudo apt-get update
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
rbenv init # follow the instructions
rbenv install 2.7.1
rbenv local 2.7.1
```

#### Install yarn

...because Javascript doesn't have enough package managers yet. 🙄

```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn
yarn install --check-files    # prevents the "integrity check" error
```

#### Install Java

OpenJDK 8 is recommended by Neo4j. OpenJDK 11 is the highest "supported" version but OpenJDK 14 seems to work fine.

```
sudo apt install openjdk-11-jdk
java --version                     # => openjdk 11.0.6 2020-01-14
update-java-alternatives --list    # => java-1.11.0-openjdk-amd64
sudo update-java-alternatives --jre --set java-1.11.0-openjdk-amd64
```

### Windows Dev Setup

#### Install Ruby

- Use the `Ruby+Devkit 2.6.6-1 (x64)` [RubyInstaller](https://rubyinstaller.org/downloads/). Ruby 2.7 **does not work** on Windows due to a nokogiri conflict. Pick the default options for the MYSYS install.

```
gem install bundler
```

#### Install Yarn

- [Install Node.js](https://nodejs.org/en/download/) using the Windows .msi installer.

```
npm install -g yarn
yarn install --check-files
```

#### Install Java

- Install OpenJDK 11 from [the RedHat .msi installer](https://developers.redhat.com/products/openjdk/download). If you have an existing Java install (> Java 8) that should also work.

#### Install Neo4j Desktop

- See instructions: [(VERY OPTIONAL) Install Neo4j Desktop](https://github.com/pariyatti/kosa/#very-optional-install-neo4j-desktop)

### Kosa Dev Setup (common to all OSes)

```
git clone git@github.com:pariyatti/kosa.git
cd kosa
bundle install          # on Windows, you will see a warning about circular dependencies - ignore
rails webpacker:install # on Windows, choose "no" for all the files it wants to replace

# Neo4j uses a separate instance for each database:
rake neo4j:install[community-3.5.17,development]    # use Neo4j Desktop on Windows, for now
rake neo4j:config[development,7005]
rake neo4j:start[development]
rake neo4j:migrate
rake neo4j:db:setup
rake neo4j:db:sample # if you want example data for development

rails s
```

Visit [http://localhost:3000](http://localhost:3000)

### Kosa Test Setup (common to all OSes)

```
rake neo4j:install[community-3.5.17,test]
rake neo4j:config[test,7008]
rake neo4j:start[test]
RAILS_ENV=test rake neo4j:migrate

rake test
```

### (VERY OPTIONAL) Install Neo4j

- **Strongly prefer `rake neo4j:install` on Linux and OSX**

You don't absolutely need to install Neo4j from a package. Instructions are provided if you want an instance of Neo4j to play with.

```
wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
# hit enter to confirm you're being asked for your sudo pw
echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
sudo apt-get install neo4j
```

### (VERY OPTIONAL) Install Neo4j Desktop

- **Strongly prefer `rake neo4j:install` on Linux and OSX**

You don't absolutely need to install Neo4j Desktop but it's a neat way of looking at your Neo4j database with the visualization tools.

- Install from: https://neo4j.com/download/
- Make the AppImage executable, run it, and then trim the whitespace from the software key the website gave you.
- Create a `Pariyatti` project with a db named `kosa3`. Turn off auth for development (to match the Rake task default). Change the ports (`Settings` tab) to avoid conflicts. Restart the db.

```
dbms.security.auth_enabled=false
dbms.connector.bolt.listen_address=:7003
dbms.connector.http.listen_address=:7001
```

## Old RSS Feeds

- [Dhamma Podcast Feed](http://feeds.pariyatti.org/dhammapodcasts)
- [Daily RSS Feed](https://www.pariyatti.org/Free-Resources/Daily-Words/RSS-Feeds)

## Contributing

The contribution guidelines can be found [here](https://github.com/pariyatti/agga/blob/master/CONTRIBUTING.md).
