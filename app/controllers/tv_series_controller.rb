class TvSeriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tv_series = Media.tv_series.paginate(page: tv_series_params[:page], limit: 60)
  end

  private

  def tv_series_params
    params.permit(:page)
  end

end
