# kosa [m.]: _store-room; treasury_

Kosa is a library, editorial, and publishing service.

## Architectural Thinking

- [The Pariyatti Data Model](https://github.com/pariyatti/agga/blob/master/docs/data-models.pdf)
- [What is a database?](https://docs.google.com/document/d/1QuiWPaAUH9_UOeBouGGCgF_FyRRhoL4uLkfKvSsbw2o/edit#)

## Development

### Linux

```
cd kosa
apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
rbenv init # follow the instructions
rbenv install 2.7.1
rbenv local 2.7.1
gem install rails
```

## Old RSS Feeds

- [Dhamma Podcast Feed](http://feeds.pariyatti.org/dhammapodcasts)
- [Daily RSS Feed](https://www.pariyatti.org/Free-Resources/Daily-Words/RSS-Feeds)
