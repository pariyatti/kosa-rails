# kosa [m.]: _store-room; treasury_

Kosa is a library, editorial, and publishing service.

## Architectural Thinking

- [The Pariyatti Data Model](https://github.com/pariyatti/agga/blob/master/docs/data-models.pdf)
- [What is a (relational) database?](https://docs.google.com/document/d/1QuiWPaAUH9_UOeBouGGCgF_FyRRhoL4uLkfKvSsbw2o/edit#)
- [What is a graph database?](https://neo4j.com/developer/graph-database/)

## Development

In general, pin versions in development the way you would in any other environment. For the time-being, we'll make exceptions for neo4j and the neo4j/activegraph gem and run them both on `latest`.

### Linux (Ubuntu 19.10)

#### Install Rails

```
cd kosa
apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
rbenv init # follow the instructions
rbenv install 2.7.1
rbenv local 2.7.1
gem install rails --version 6.0.2.2            # optional - any 6.x variant should be fine
gem install neo4j neo4j-core neo4j-rake_tasks  # run latest in dev
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


## Old RSS Feeds

- [Dhamma Podcast Feed](http://feeds.pariyatti.org/dhammapodcasts)
- [Daily RSS Feed](https://www.pariyatti.org/Free-Resources/Daily-Words/RSS-Feeds)
