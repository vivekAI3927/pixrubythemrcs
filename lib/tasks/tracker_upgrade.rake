desc "This task adds attempts linking all the available stations to all the current users"
task :add_attempts_to_current_users => :environment do
  puts 'Adding attempts for current users'
  User.all.each do |user|
    puts "Adding stations for user #{user.email}"
    # only for available stations, unavailable functionality is now defunct.
    Station.all.each do |station|
      Attempt.create(station_id: station.id, user_id: user.id)
    end
  end
end