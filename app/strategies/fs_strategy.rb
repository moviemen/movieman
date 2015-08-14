require 'mechanize'

class FsStrategy

  def initialize
    @series_page = 'http://fs.to/video/serials/'
    @mechanize   = Mechanize.new
    @page_number = nil
    @page        = nil
  end

  def check_for_updates
    @page_number = 1
    begin
      parse_page
    rescue
      puts "\nTHE ERROR."
    end
    puts "\nTHE END."
  end

  def parse_page
    @page = @mechanize.get( @series_page + "?page=#{@page_number}" )
    list  = @page.search('.b-section-list') 
    
    return if list.text.include?('Таких материалов не найдено')

    list.search('.b-section-list .b-poster-tile').each do |series|
      s_url   = 'http://fs.to' + series.search('.b-poster-tile__link').attr('href').value
      s_name  = series.search('.b-poster-tile__title-full').text.gsub(/\t/, '').gsub(/\n/, '')
      updates = parse_episode_page(s_url)
      parsed_episode = Episode.new( name: s_name, url: s_url, last_season:  updates[:season], last_episode: updates[:episode], photo: updates[:photo])
      update_episode parsed_episode if parsed_episode.last_season && parsed_episode.last_episode
    end

    @page_number += 1
    parse_page
  end

  def parse_episode_page url
    series_page = @mechanize.get( url )
    tmp_arr  = series_page.search('.l-tab-item-content table').text # 'сезон 05 серия 04'
    tmp_arr2 = tmp_arr.split('сезон ')[1].split(' ')
    photo = series_page.search('.l-left .poster-main .images-show img').attr('src')
    {season: tmp_arr2[0].to_i, episode: tmp_arr2[2].to_i, photo: photo}
  end

  private

  def update_episode parsed_episode
    episode = Episode.find_by_url( parsed_episode.url )
    if episode
      if episode.last_season.nil? || episode.last_episode.nil?
        episode.update(last_season: parsed_episode.last_season, last_episode: parsed_episode.last_episode)
        puts "UPDATES FOR #{episode.name} - new episode #{parsed_episode.last_episode}"
      else      
        if parsed_episode.last_season == episode.last_season && parsed_episode.last_episode > episode.last_episode
          episode.update(last_season: parsed_episode.last_season, last_episode: parsed_episode.last_episode)
          puts "UPDATES FOR #{episode.name} - new episode #{parsed_episode.last_episode}"
        elsif parsed_episode.last_season > episode.last_season
          episode.update(last_season: parsed_episode.last_season, last_episode: parsed_episode.last_episode)
          puts "UPDATES FOR #{episode.name} - new episode #{parsed_episode.last_episode}"
        else
          puts "NO CHANGES FOR #{episode.name}"
        end
      end
    else
      parsed_episode.save!
      puts "CREATE new series #{parsed_episode.name}"
    end
  end

end