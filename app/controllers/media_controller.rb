class MediaController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies        = Media.tv_series.page(0)
    @tv_series     = Media.tv_series.page(0)
    @subscriptions = Media.tv_series.page(0)
  end

  private

  def media_params
    params.permit(:page)
  end

end
