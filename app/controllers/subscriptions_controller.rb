class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    media_ids      = current_user.subscriptions.pluck(:media_id)
    @subscriptions = Media.where(:_id.in => media_ids).page(subscription_params[:page])
    
    data = @subscriptions.map do |subscription| 
      render_to_string partial: 'media/subscription', locals: {subscription: subscription}
    end

    render json: {status: 200, data: data.join(''), total: @subscriptions.count}
  end

  def create
    if media = Media.find(media_id: subscription_params[:media_id])
      current_user.subscriptions.find_or_create_by(media_id: subscription_params[:media_id])
      render json: {status: 200, msg: 'OK.'}
    else
      render json: {status: 400, msg: 'FAIL.'}
    end
  end

  def delete
    if media = Media.find(media_id: subscription_params[:media_id])
      current_user.subscriptions.find(media_id: subscription_params[:media_id]).delete
      render json: {status: 200, msg: 'OK.'}
    else
      render json: {status: 400, msg: 'FAIL.'}
    end
  end

  private

  def subscription_params
    params.permit(:page, :media_id)
  end

end
