class MediaController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Media.movies.page(0)
  end

  private

  def media_params
    params.permit(:page)
  end

end
