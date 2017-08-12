# Campaign Autoresponder Modeler

## Description

This is a simple Rails app which models a campaign autoresponder. It's not meant to be a fully functional rails application, but simply the database schema, models, and logic which makes the decisions about where the user goes next on the graph.

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

5. Run the modeler. This modeler rake task will run a simulation of a user traversing the graph. The decisions on whether or not the user waited a particular delay, or chose to open an email are made at random. Each running of the modeler will yield a different result. The model graph is contained `seeds.rb`. An example is shown below (`C2E1` stands for "Campaign 2, Email 1").

   ```
     $ bundle exec rake model

     User received initial campaign email: C1E1
     User received C2E1 because they opened C1E1
     User received C2E2 because they waited 20 hours
     User received C2E3 because they waited 10 hours
     User received C6E1 because they waited 9 hours
     User received C7E1 because they waited 8 hours
   ```

## Approach

1. As I tend to build things from the bottom-up, I first came up with the database schema requirements:

   - A campaign node has an initial email and a title, and a flag if it is the root node
   - An email node has a next email (in case of a delay), and a next campaign (for a binary branch)
   - An email also needs subject line, body, and a delay amount to tell the system when the next email should be sent
   - A user has a current email, campaign and user data such as name and email

2. The architecture is such that the user's data will keep its place in the graph by using `current_campaign` and `current_email`. The `Campaign` and `Email` models are parent-child relationships. A `Campaign` needs to know the first email in the graph, and an `Email` needs to know the next `Email` or `Campaign` in the graph.

3. All of the logic around whether or not a user will move on to the next email or campaign is contained within `User::CampaignGraph` under the `/models/user/` directory. This class is responsible for updating the user's current position (email and campaign) within the model.

4. All models and the `User::CampaignGraph` class were built using TDD with a BDD style approach. The test suite should be fairly comprehensive.

5. The rake task `rake model` is for simulating what happens if the user starts at the initial campaign and email, and then either waits or clicks on every email after that point. The decision of waiting or clicking is chosen randomly to simulate where the user goes next. The result is printed to the console. Check the `seeds.rb` file for a description of what the model looks like.
