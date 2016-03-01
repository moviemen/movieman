namespace :scrape do

  desc 'scrape fs.to'
  task :fs => :environment do
    FsScraper.new.sync_media
  end

end
