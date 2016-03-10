class Fs::TvSeries

  def initialize page_number=nil
    @series_page = 'http://fs.to/video/serials/'
    @mechanize   = Mechanize.new
    @page_number = page_number
    @page        = nil
  end

  def sync
    @page_number = 0
    #begin
      parse_page
    #rescue
    #  puts "\nTHE ERROR."
    #end
    puts "\nTHE END."
  end

  def parse_page
    print @page_number
    @page = @mechanize.get( @series_page + "?page=#{@page_number}" )
    list  = @page.search('.b-section-list') 

    return if list.text.include?('Таких материалов не найдено')

    list.search('.b-section-list .b-poster-tile').each do |series|
      s_url   = 'http://fs.to' + series.search('.b-poster-tile__link').attr('href').value
      s_name  = series.search('.b-poster-tile__title-full').text.gsub(/\t/, '').gsub(/\n/, '')
      updates = parse_episode_page(s_url)

      @media = {}
      @media = {
        name:     s_name,
        kind:     'tv_series',
        link:     s_url,
        picture:  updates[:picture],
        season:   updates[:season],
        episode:  updates[:episode]
      }

      begin
        update_episode @media if @media[:season] && @media[:episode]
      rescue
      end
    end

    @page_number += 1
    parse_page
  end

  def parse_episode_page url
    series_page = @mechanize.get( url )
    tmp_arr  = series_page.search('.l-tab-item-content table').text # 'сезон 05 серия 04'
    tmp_arr2 = tmp_arr.split('сезон ')[1].split(' ')
    picture  = series_page.search('.l-left .poster-main .images-show img').attr('src').value
    {season: tmp_arr2[0].to_i, episode: tmp_arr2[2].to_i, picture: picture}
  end

  def update_episode media
    tv_series = Media::TvSeries.where(name: media[:name], kind: media[:kind]).first_or_initialize!

    if tv_series.picture.nil?
      picture_name = "#{tv_series.id.to_s}#{File.extname(media[:picture])}"
      @mechanize.get(media[:picture]).save( "#{Rails.root}/app/assets/images/tv_series/#{picture_name}" )
      tv_series.picture = picture_name
    end

    if parsed_source.season.nil? || parsed_source.episode.nil?
      tv_series.season  = media[:season]
      tv_series.episode = media[:episode]
    else
      if media[:season] == tv_series.season && media[:episode] > tv_series.episode
        tv_series.episode = media[:episode]
      elsif media[:season] > tv_series.season
        tv_series.season  = media[:season]
        tv_series.episode = media[:episode]
      end
    end

    tv_series.link = media[:link]

    print '.' if tv_series.save!
  end

end