class MediaController < ApplicationController
  before_action :set_media, only: [:show, :edit, :update, :destroy]

  # GET /media
  def index
    @media = Media.all
  end

  # GET /media/1
  def show
  end

  # GET /media/new
  def new
    @media = Media.new
  end

  # GET /media/1/edit
  def edit
  end

  # POST /media
  def create
    @media = Media.new(media_params)

    if @media.save
      redirect_to @media, notice: 'Media was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /media/1
  def update
    if @media.update(media_params)
      redirect_to @media, notice: 'Media was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /media/1
  def destroy
    @media.destroy
    redirect_to media_index_url, notice: 'Media was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media
      @media = Media.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def media_params
      params.require(:media).permit(:type, :name)
    end
end
