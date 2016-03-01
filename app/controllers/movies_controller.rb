class MoviesController < ApplicationController

  # GET /media
  def index
    @movies = Media.movies.limit 30
  end

end
