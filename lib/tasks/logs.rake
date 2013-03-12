namespace :logs do
  task :reset_positions => :environment do
    Log.all.each do |log|
      log.reset_positions
    end
  end
end