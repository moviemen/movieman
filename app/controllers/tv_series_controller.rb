class TvSeriesController < ApplicationController

  # GET /media
  def index
    @tv_series = Media.tv_series
  end

end
