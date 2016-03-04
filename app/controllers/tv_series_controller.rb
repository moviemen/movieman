class TvSeriesController < ApplicationController
  before_action :authenticate_user!

  def index
    media = Media.tv_series.page(tv_series_params[:page])
    data  = render_to_string partial: 'media/tv_series', collection: media

    render json: {status: 200, data: data}
  end

  private

  def tv_series_params
    params.permit(:page)
  end

end
