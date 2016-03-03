class MediaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  private

  def media_params
    params.permit(:page)
  end

end
