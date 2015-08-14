namespace :scrape_for do

  desc "parse episodes into database"
  task fresh_episodes: :environment do
    FsStrategy.new.check_for_updates
  end

end