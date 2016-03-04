class Fs::Movie

  def initialize
    @movies_page = 'http://fs.to/video/films/'
    @mechanize   = Mechanize.new
    @page_number = nil
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
    @page = @mechanize.get( @movies_page + "?page=#{@page_number}" )
    list  = @page.search('.b-section-list')

    return if list.text.include?('Таких материалов не найдено')

    list.search('.b-section-list .b-poster-tile').each do |movies|
      s_url   = 'http://fs.to' + movies.search('.b-poster-tile__link').attr('href').value
      s_name  = movies.search('.b-poster-tile__title-full').text.gsub(/\t/, '').gsub(/\n/, '')
      updates = parse_movie_page(s_url)

      @media = {}
      @media = {
          name:     s_name,
          type:     'movies',
          link:     s_url,
          picture:  updates[:picture],
          released: updates[:released]
      }

      update_movie @media unless @media[:released].nil?
    end

    @page_number += 1
    parse_page
  end


  def parse_movie_page url

    movie_page = @mechanize.get( url )
    picture    = movie_page.search('.l-left .poster-main .images-show img').attr('src').value
    url = url + '?ajax&folder=0'
    movie_page = @mechanize.get( url )
    released   = !movie_page.search('.filelist .folder-language').empty?
    {picture: picture, released: released}
  end

  def update_movie media
    parsed_media  = Media.where(name: media[:name], type: media[:type]).first_or_create!

    if parsed_media.picture.nil?
      picture_name = "#{parsed_media.id.to_s}#{File.extname(media[:picture])}"
      @mechanize.get(media[:picture]).save( "#{Rails.root}/app/assets/images/movies/#{picture_name}" )
      parsed_media.update(picture: picture_name)
    end

    parsed_source = parsed_media.sources.where(link: /fs.to/).first

    if parsed_source
      if parsed_source.released == false && media[:released]
        parsed_source.update!(released: media[:released])
        puts "UPDATES FOR #{parsed_source.media.name} - released"
      else
        puts "NO CHANGES FOR #{parsed_source.media.name}"
      end
    else
      parsed_media.sources.create link: media[:link], released: media[:released]
      puts "CREATE new movies #{parsed_media.name}"
    end
  end
end