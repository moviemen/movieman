class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.notification.update(notification_params)
      render json: {status: 200, msg: 'OK.'}
    end
  end

  private

  def notification_params
    params.permit(:mail)
  end

end