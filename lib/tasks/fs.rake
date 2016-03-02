namespace :scrape do

  desc 'scrape fs.to'
  namespace :fs do

    desc 'scrape fs.to Movies'
    task :movies => :environment do
      Fs::Movie.new.sync
    end

    desc 'scrape fs.to TV Series'
    task :tv_series => :environment do
      Fs::TvSeries.new.sync
    end

  end

end
