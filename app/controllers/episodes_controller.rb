class EpisodesController < ApplicationController

  # GET /episodes/index
  def index
    @episodes = Episode.paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def blocks
    set_view_mode 1
    redirect_to   root_path
  end

  def table
    set_view_mode 0
    redirect_to   root_path
  end

  private

    def set_view_mode mode=0
      current_user.update(view_mode: mode)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params[:episode]
    end
end
