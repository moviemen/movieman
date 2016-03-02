class MediaController < ApplicationController
  before_action :authenticate_user!

  def index
    @media = Media.tv_series.asc(:name).paginate(page: tv_series_params[:page], limit: 60)
  end

  private

  def tv_series_params
    params.permit(:page)
  end

end
