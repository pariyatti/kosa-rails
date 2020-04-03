# kosa [m.]: _store-room; treasury_

Kosa is a library, editorial, and publishing service.

## Architectural Thinking

- [The Pariyatti Data Model](https://github.com/pariyatti/agga/blob/master/docs/data-models.pdf)
- [What is a (relational) database?](https://docs.google.com/document/d/1QuiWPaAUH9_UOeBouGGCgF_FyRRhoL4uLkfKvSsbw2o/edit#)
- [What is a graph database?](https://neo4j.com/developer/graph-database/)

## Development

In general, pin versions in development the way you would in any other environment. For the time-being, we'll make exceptions for neo4j and the neo4j/activegraph gem and run them both on `latest`.

The neo4j.rb docs are here:

https://neo4jrb.readthedocs.io/en/v9.4.0/

### Linux (Ubuntu 19.10)

#### Install Rails

```
cd kosa
apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
rbenv init # follow the instructions
rbenv install 2.7.1
rbenv local 2.7.1
```

#### Install Neo4j

General instructions: https://neo4j.com/docs/operations-manual/current/installation/linux/debian/#debian-installation

```
sudo apt install openjdk-11-jdk
java --version # => openjdk 11.0.6 2020-01-14
update-java-alternatives --list
sudo update-java-alternatives --jre --set <java-11-name>

wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
# hit enter to confirm you're being asked for your sudo pw
echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
apt list -a neo4j
sudo apt-get install neo4j
```

#### Install Neo4j Desktop (optional)

https://neo4j.com/download/

- Make the AppImage executable, run it, and then trim the whitespace from the software key the website gave you.
- Create a `Pariyatti` project with a db named `kosa`. Turn off auth for development (to match the Rake task default). Change the ports (`Settings` tab) to avoid conflicts. Restart the db.

```
dbms.security.auth_enabled=false
dbms.connector.bolt.listen_address=:7000
dbms.connector.http.listen_address=:7001
```

#### Setup Rails

```
cd kosa
bundle install
# use neo4j:install if you don't want neo4j desktop.
# this didn't work for me but i'm on side-of-a-mountain internet:
rake neo4j:install[community-latest,development] # 3.4.1

# install yarn:
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

rails webpacker:install
```

## Old RSS Feeds

- [Dhamma Podcast Feed](http://feeds.pariyatti.org/dhammapodcasts)
- [Daily RSS Feed](https://www.pariyatti.org/Free-Resources/Daily-Words/RSS-Feeds)

## Contributing

The contribution guidelines can be found [here](https://github.com/pariyatti/agga/blob/master/CONTRIBUTING.md).
