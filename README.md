# Campaign Autoresponder Modeler

## Description

This is a simple Rails app which models a campaign autoresponder. It's not meant to be a fully functional rails application, but simply the database and a class which makes the decisions on how it's used.

## Project Setup

I personally use [rbenv](https://github.com/rbenv/rbenv) along with [rbenv-gemset](https://github.com/jf/rbenv-gemset) (optional, but easier to deal with since I'm running multiple projects), hence the `.ruby-version` and `.rbenv-gemsets` files. If these cause problems for you, I suggest removing them.

1. This app was bundled with Ruby 2.4.1, so ensure it is installed on your machine.

2. Run your standard bundle commands

```
  $ gem install bundler
  $ bundle
  $ rbenv rehash
```

3. Set up the database

```
  $ bundle exec rake db:setup
```

If you choose to run the setup commands separately, such as:

```
  $ bundle exec rake db:create
  $ bundle exec rake db:migrate
  $ bundle exec rake db:test:prepare
  $ bundle exec rake db:seed
```

Ensure that you run `bundle exec rake db:seed` as well. Otherwise, the modeling graph data will not be seeded. It is recommended you destroy the database and set it up again if you've made changes, otherwise the modeler may behave unexpectedly (Step 5).

4. Run the test suite:

```
  $ bundle exec rake
```

The tests were written in RSpec and they should pass 100%, at the time of this writing.

5. Run the modeler. This modeler rake task will run a simulation of a user traversing the graph. The decisions on whether or not the user waited a particular delay, or chose to open an email are made at random. Each running of the modeler will yield a different result. The model graph is contained `seeds.rb`. An example is shown below.

```
  $ bundle exec rake model

  User received initial campaign email: C1E1
  User received C2E1 because they opened C1E1
  User received C2E2 because they waited 20 hours
  User received C2E3 because they waited 10 hours
  User received C6E1 because they waited 9 hours
  User received C7E1 because they waited 8 hours
```
