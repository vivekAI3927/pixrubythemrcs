desc "This task sends an email to those who registered a week ago but did not pay"
task :not_join_message => :environment do
  puts "Sending not joined messages"
  # send an email to all those who registered a week ago and did not subscribe
  User.send_not_joined_messages
  puts "Done."
end
