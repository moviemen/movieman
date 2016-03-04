class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    media = Media.movies.page(movies_params[:page])
    data  = render_to_string partial: 'media/movie', collection: media

    render json: {status: 200, data: data}
  end

  private

  def movies_params
    params.permit(:page)
  end

end
