class SynonymsController < ApplicationController
  before_action :set_synonym, only: [:show, :edit, :update, :destroy]

  # GET /synonyms
  def index
    @synonyms = Synonym.all
  end

  # GET /synonyms/1
  def show
  end

  # GET /synonyms/new
  def new
    @synonym = Synonym.new
  end

  # GET /synonyms/1/edit
  def edit
  end

  # POST /synonyms
  def create
    @synonym = Synonym.new(synonym_params)

    if @synonym.save
      redirect_to @synonym, notice: 'Synonym was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /synonyms/1
  def update
    if @synonym.update(synonym_params)
      redirect_to @synonym, notice: 'Synonym was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /synonyms/1
  def destroy
    @synonym.destroy
    redirect_to synonyms_url, notice: 'Synonym was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_synonym
      @synonym = Synonym.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def synonym_params
      params.require(:synonym).permit(:name, :media_id)
    end
end
