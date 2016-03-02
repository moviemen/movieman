class MediaController < ApplicationController
  before_action :authenticate_user!

  def index
    @media = Media.tv_series.page(media_params[:page])

    if request.xhr?
      data = @media.map{ |media| render_to_string partial: 'media', locals: {media: media} }
      render json: {status: 200, data: data.join(''), total: @media.count}
    end
  end

  private

  def media_params
    params.permit(:page)
  end

end
