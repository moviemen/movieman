class NotificationsController < ApplicationController

  def subscribe_via_email
    if current_user.update_attributes(email_notified: params[:email_subscribed])
      render json: {status: 200, data: current_user.email_notified}
    end
  end

end