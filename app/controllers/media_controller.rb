class MediaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def search
    media_ids = Media.search('*' + search_params[:search] + '*').records.pluck(:id)

    render json: {status: 200, data: media_ids}
  end

  def search_params
    params.permit(:search, :media_kind, :page)
  end

end
