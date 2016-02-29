class MoviesController < ApplicationController

  # GET /media
  def index
    @movies = Media.movies
  end

end
