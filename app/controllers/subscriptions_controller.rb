class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription,  only: [:destroy] 

  def index
    media_ids     = current_user.subscriptions.pluck(:media_id)
    subscriptions = Media.where(:_id.in => media_ids).page(subscription_params[:page])
    data          = render_to_string partial: 'media/subscription', collections: subscriptions

    render json: {status: 200, data: data, total: subscriptions.count}
  end

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

  private

  def set_subscription
    @subscription = Subscription.find(subscription_params[:id])
  end

  def subscription_params
    params.permit(:page, :media_id, :id)
  end

end
