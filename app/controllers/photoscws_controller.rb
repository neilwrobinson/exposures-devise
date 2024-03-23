# Photos using Carrier Wave instead of Active Storage (As a learning Point)
class PhotoscwsController < ApplicationController
  before_action :set_photoscw, only: %i[ show edit update destroy ]

  # GET /photoscws or /photoscws.json
  def index
    @photoscws = Photoscw.all
  end

  # GET /photoscws/1 or /photoscws/1.json
  def show
  end

  # GET /photoscws/new
  def new
    @photoscw = Photoscw.new
  end

  # GET /photoscws/1/edit
  def edit
  end

  # POST /photoscws or /photoscws.json
  def create
    @photoscw = Photoscw.new(photoscw_params)

    respond_to do |format|
      if @photoscw.save
        format.html { redirect_to photoscw_url(@photoscw), notice: "Photoscw was successfully created." }
        format.json { render :show, status: :created, location: @photoscw }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photoscw.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photoscws/1 or /photoscws/1.json
  def update
    respond_to do |format|
      if @photoscw.update(photoscw_params)
        format.html { redirect_to photoscw_url(@photoscw), notice: "Photoscw was successfully updated." }
        format.json { render :show, status: :ok, location: @photoscw }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photoscw.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photoscws/1 or /photoscws/1.json
  def destroy
    @photoscw.destroy

    respond_to do |format|
      format.html { redirect_to photoscws_url, notice: "Photoscw was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photoscw
      @photoscw = Photoscw.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def photoscw_params
      params.require(:photoscw).permit(:date, :title, :location, :description, :image)
    end
end
