class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    subscriptions = Media.where(user_ids: current_user.id).page(subscription_params[:page])
    data          = render_to_string partial: 'media/subscription', collection: subscriptions

    render json: {status: 200, data: data, total: subscriptions.count}
  end
=begin
  def create
    if subscription = Subscription.create(user_id: current_user.id, media_id: subscription_params[:media_id])
      render json: {status: 200, msg: 'OK.', subscription_id: subscription.id.to_s}
    end
  end

  def destroy
    media_id = @subscription.media_id
    if @subscription.delete
      render json: {status: 200, msg: 'OK.', media_id: media_id.to_s}
    end
  end
=end
  private

  def subscription_params
    params.permit(:page, :media_id, :id)
  end

end
