class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Media.movies.page(movies_params[:page])
    data    = @movies.map{ |movie| render_to_string partial: 'media/movies', locals: {movies: movie} }

    render json: {status: 200, data: data.join(''), total: @movies.count}
  end

  private

  def movies_params
    params.permit(:page)
  end

end
