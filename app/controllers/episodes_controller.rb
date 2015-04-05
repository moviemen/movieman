class EpisodesController < ApplicationController
  respond_to :json

  def index
    respond_with Episode.all
  end

  def my
    respond_with User.first.episodes
  end

  private

  def post_params
    params.require(:post).permit(:name, :url, :photo, :last_season, :last_episode, :updated_at)
  end
end