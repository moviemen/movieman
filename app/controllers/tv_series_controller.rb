class TvSeriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tv_series = Media.tv_series.page(tv_series_params[:page])
    data       = @tv_series.map{ |tv_series| render_to_string partial: 'media/tv_series', locals: {tv_series: tv_series} }

    render json: {status: 200, data: data.join(''), total: @tv_series.count}
  end

  private

  def tv_series_params
    params.permit(:page)
  end

end
