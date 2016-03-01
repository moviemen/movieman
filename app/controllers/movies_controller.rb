class MoviesController < ApplicationController

  # GET /media
  def index
    @movies = Media.movies.limit 10
  end

end
