# kosa [m.]: _store-room; treasury_

Kosa is a library, editorial, and publishing service.

## Architectural Thinking

- [The Pariyatti Data Model](https://github.com/pariyatti/agga/blob/master/docs/data-models.pdf)
- [What is a (relational) database?](https://docs.google.com/document/d/1QuiWPaAUH9_UOeBouGGCgF_FyRRhoL4uLkfKvSsbw2o/edit#)
- [What is a graph database?](https://neo4j.com/developer/graph-database/)

## Mobile App API

The Pariyatti mobile app will consume the API as specified [here](https://github.com/pariyatti/kosa/blob/master/docs/api.md).

### Option 1: Set up a local development server

Follow the instructions under [Development](https://github.com/pariyatti/kosa#development). Use this option if you need to modify or debug the server itself.

### Option 2: Use the Sandbox server

`http://139.59.41.132` - Use this option if you will working exclusively on the mobile app without modifying or debugging the server.

## Development

In general, pin versions in development the way you would in any other environment. For the time-being, we'll make exceptions for neo4j and the neo4j/activegraph gem and run them both on `latest`.

There is a lot of old documentation out there. Use these:

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

#### Install Neo4j

```
wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
# hit enter to confirm you're being asked for your sudo pw
echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
sudo apt-get install neo4j
```

#### Install Neo4j Desktop (optional)

https://neo4j.com/download/

- Make the AppImage executable, run it, and then trim the whitespace from the software key the website gave you.
- Create a `Pariyatti` project with a db named `kosa3`. Turn off auth for development (to match the Rake task default). Change the ports (`Settings` tab) to avoid conflicts. Restart the db.

```
dbms.security.auth_enabled=false
dbms.connector.bolt.listen_address=:7000
dbms.connector.http.listen_address=:7001
```

#### Setup Rails

```
cd kosa
bundle install
rails webpacker:install

# use `neo4j:install` if you don't want neo4j desktop.
# this didn't work for me but i'm on side-of-a-mountain internet -sd
rake neo4j:install[community-latest,development] # 3.4.1

rake neo4j:setup
rake test
```

## Old RSS Feeds

- [Dhamma Podcast Feed](http://feeds.pariyatti.org/dhammapodcasts)
- [Daily RSS Feed](https://www.pariyatti.org/Free-Resources/Daily-Words/RSS-Feeds)

## Contributing

The contribution guidelines can be found [here](https://github.com/pariyatti/agga/blob/master/CONTRIBUTING.md).
