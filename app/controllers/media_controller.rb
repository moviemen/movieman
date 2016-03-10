class MediaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def search
    media = Media.search('*' + search_params[:search] + '*').records

    case search_params[:media_kind]
      when 'movies'
        media = media.movies
        kind = 'movie'
      when 'tv_series'
        media = media.tv_series
        kind = 'tv_series'
      when 'subscriptions'


    end

    data  = render_to_string partial: "media/#{kind}", collection: media

    render json: {status: 200, data: data}
  end

  def search_params
    params.permit(:search, :media_kind, :page)
  end

end
