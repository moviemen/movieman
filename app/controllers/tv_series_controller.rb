class TvSeriesController < ApplicationController
  before_action :authenticate_user!

  # GET /media
  def index
    @tv_series = Media.tv_series.limit 10
  end

end
