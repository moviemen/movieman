class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_media, only: [:create, :destroy]

  def index
    media = Media.where(user_ids: current_user.id).page(subscription_params[:page])
    data  = render_to_string partial: 'media/subscription', collection: media

    render json: {status: 200, data: data}
  end

  def create
    if @media.users << current_user
      render json: { status: 200, msg: 'OK.'}
    end
  end

  def destroy
    if @media.users.delete(current_user)
      render json: {status: 200, msg: 'OK.'}
    end
  end

  private

  def find_media
    @media = Media.find(subscription_params[:id])
  end

  def subscription_params
    params.permit(:page, :id)
  end

end
