class MediaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def search
    media_ids = Media.search(search_params[:search]).records.pluck(:id)

    # media = Media.where(user_ids: current_user.id).page(subscription_params[:page])
    # data  = render_to_string partial: 'media/subscription', collection: media

    render json: {status: 200, media_ids: media_ids}
  end

  def search_params
    params.permit(:search, :page)
  end

end
