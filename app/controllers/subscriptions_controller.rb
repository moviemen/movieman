class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    media_ids      = current_user.subscriptions.pluck(:media_id)
    @subscriptions = Media.where(:_id.in => media_ids).page(subscription_params[:page])
    data           = @subscriptions.map{ |subscription| render_to_string partial: 'media/subscription', locals: {subscription: subscription} }

    render json: {status: 200, data: data.join(''), total: @subscriptions.count}
  end

  private

  def subscription_params
    params.permit(:page)
  end

end
