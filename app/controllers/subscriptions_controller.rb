class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    media = Media.where(user_ids: current_user.id).page(subscription_params[:page])
    data  = render_to_string partial: 'media/subscription', collection: media

    render json: {status: 200, data: data}
  end

  def create
    if subscription = Media.find(subscription_params[:media_id]).users << current_user
      render json: { status: 200, msg: 'OK.'}
    end
  end

  def destroy
    media = Media.find(subscription_params[:id])

    if subscription = media.users.delete(current_user)
      render json: {status: 200, msg: 'OK.'}
    end
  end

  private

  def subscription_params
    params.permit(:media_id, :page, :id)
  end

end
