class FsMovieScraper
  def initialize
    @movies_page = 'http://fs.to/video/films/'
    @mechanize   = Mechanize.new
    @page_number = nil
    @page        = nil
  end

  def sync_media
    @page_number = 0
    #begin
    parse_page
    #rescue
    #  puts "\nTHE ERROR."
    #end
    puts "\nTHE END."
  end

  def parse_page
    @page = @mechanize.get( @movies_page + "?page=#{@page_number}" )
    list  = @page.search('.b-section-list')

    return if list.text.include?('Таких материалов не найдено')

    list.search('.b-section-list .b-poster-tile').each do |movies|
      s_url   = 'http://fs.to' + movies.search('.b-poster-tile__link').attr('href').value
      s_name  = movies.search('.b-poster-tile__title-full').text.gsub(/\t/, '').gsub(/\n/, '')
      # updates = parse_episode_page(s_url)

      @media = {}
      @media = {
          name:     s_name,
          type:     'movie',
          link:     s_url,
          picture:  updates[:picture]
      }
  #
  #     update_episode @media if @media[:season] && @media[:episode]
    end
  #
  #   @page_number += 1
  #   parse_page
  end
end