class MoviesController < ApplicationController

  def index
    @movies = Media.movies.paginate(page: movies_params[:page], limit: 10)
  end

  private

  def movies_params
    params.permit(:page)
  end

end
