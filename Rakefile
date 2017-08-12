# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc "Run the modeler to simulate a CampaignGraph traversal based on random user waiting or opening the emails"
task :model => :environment do
  user = User.first
  graph = User::CampaignGraph.new(user)
  graph.start

  puts "User received initial campaign email: #{user.current_email.subject_content}"

  while graph.advanced do
    initial_email = user.current_email
    random_open_decision = [true, false].sample

    if (random_open_decision)
      graph.advance_for_branch
      puts "User received #{user.current_email.subject_content} because they opened #{initial_email.subject_content}" if graph.advanced
    else
      graph.advance_for_delay
      puts "User received #{user.current_email.subject_content} because they waited #{initial_email.hours_delay} hours" if graph.advanced
    end
  end
end
