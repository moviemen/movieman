class Fs::Movie

  def initialize page_number=nil
    @movies_page = 'http://fs.to/video/films/'
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
        kind:     'movies',
        link:     s_url,
        picture:  updates[:picture],
        released: updates[:released]
      }

      begin
        update_movie @media unless @media[:released].nil?
      rescue
      end
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
    movie = Media::Movie.where(name: media[:name], kind: media[:kind]).first_or_initialize!

    if movie.picture.nil?
      picture_name = "#{movie.id.to_s}#{File.extname(media[:picture])}"
      @mechanize.get(media[:picture]).save( "#{Rails.root}/app/assets/images/movies/#{picture_name}" )
      movie.picture = picture_name
    end

    movie.released = media[:released] if media[:released] && !movie.released
    movie.link     =  media[:link]    if media[:released]
    print '.' if movie.save!
  end

end
