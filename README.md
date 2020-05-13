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

### Option 1: Set up a local development server

Follow the instructions under [Development](https://github.com/pariyatti/kosa#development). Use this option if you need to modify or debug the server itself.

### Option 2: Use the Sandbox server

[http://kosa-sandbox.pariyatti.org](http://kosa-sandbox.pariyatti.org) - Use this option if you will working exclusively on the mobile app without modifying or debugging the server.

## Development

In general, pin versions in development the way you would in any other environment.

There is a lot of old `Neo4j.rb` documentation out there. Use these:

- https://neo4jrb.readthedocs.io/en/v9.4.0/
- https://gitter.im/neo4jrb/neo4j (look for @klobuczek and @amitTheSongadya_twitter)
- https://neo4j.com/developer/ruby/

### Linux (Ubuntu 19.10)

#### Prepare

```
git clone git@github.com:pariyatti/kosa.git
cd kosa
sudo apt-get update
```

#### Install Ruby

```
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
```

#### Install Java

```
sudo apt install openjdk-11-jdk
java --version                  # => openjdk 11.0.6 2020-01-14
update-java-alternatives --list # => java-1.11.0-openjdk-amd64
sudo update-java-alternatives --jre --set java-1.11.0-openjdk-amd64
```

#### Setup Rails

```
cd kosa
bundle install
rails webpacker:install

# Neo4j uses a separate instance for each database:
rake neo4j:install[community-3.5.17,development]
rake neo4j:config[development,7005]
rake neo4j:start[development]
rake neo4j:migrate
rake neo4j:db:setup
rake neo4j:db:sample # if you want example data for development

rails s
```

Visit [http://localhost:3000](http://localhost:3000)

#### Run the tests

```
rake neo4j:install[community-3.5.17,test]
rake neo4j:config[test,7008]
rake neo4j:start[test]
RAILS_ENV=test rake neo4j:migrate

rake test
```

#### (VERY OPTIONAL) Install Neo4j

You don't absolutely need to install Neo4j from a package. Instructions are provided if you want an instance of Neo4j to play with. It's strongly recommended that you use `rake neo4j:install` for development and test environments.

```
wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
# hit enter to confirm you're being asked for your sudo pw
echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
sudo apt-get install neo4j
```

#### (VERY OPTIONAL) Install Neo4j Desktop

You don't absolutely need to install Neo4j Desktop but it's a neat way of looking at your Neo4j database with the visualization tools.

- Install from: https://neo4j.com/download/
- Make the AppImage executable, run it, and then trim the whitespace from the software key the website gave you.
- Create a `Pariyatti` project with a db named `kosa3`. Turn off auth for development (to match the Rake task default). Change the ports (`Settings` tab) to avoid conflicts. Restart the db.

```
dbms.security.auth_enabled=false
dbms.connector.bolt.listen_address=:7003
dbms.connector.http.listen_address=:7001
```

### Windows
```
git clone git@github.com:pariyatti/kosa.git
cd kosa
```

### Install Ruby
```
- Install using [RubyInstaller](https://rubyinstaller.org/downloads/) (Ruby+Devkit 2.6.6-1 (x64))
- Pick the default options for MYSYS install

gem install bundler
```

### Install Yarn

You will need node for this. You can [install node]() here
```
npm install -g yarn
```

### Install Java

- You will need to install JDK11 from [RedHat](https://developers.redhat.com/products/openjdk/download)


## Old RSS Feeds

- [Dhamma Podcast Feed](http://feeds.pariyatti.org/dhammapodcasts)
- [Daily RSS Feed](https://www.pariyatti.org/Free-Resources/Daily-Words/RSS-Feeds)

## Contributing

The contribution guidelines can be found [here](https://github.com/pariyatti/agga/blob/master/CONTRIBUTING.md).
