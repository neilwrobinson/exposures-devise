class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]

  # GET /photos or /photos.json
  def index
    @photos = Photo.all.order(date: :desc)
  end
  
  # GET /photos
  def timeseries
    # 'year' is the option to truncate the date to a year and filter by distinct (no duplicates)
    # therefore, we should only have a range from the early 1800s (I guess that's when the first photo was taken)
    # to present; therefore, it isn't too much to handle for Ruby to loop through in the .each method.
    @photos = Photo.select("date_trunc('year', date)").distinct.order(date_trunc: :desc)
  end

  def timeseries_year
    start_year = Time.new(params[:id].to_i)
    #puts "====>>>>" + start_year.to_s
    @year = start_year.year.to_s

    # To be safe, I added hash braces to avoid sql injection. I believe it would be safe without.
    @photos = Photo.where({:date => start_year..start_year.next_year}) 
  end

  # GET /photos/1 or /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos or /photos.json
  def create
    @photo = Photo.new(photo_params.except(:tags))
    create_or_delete_posts_tags(@photo, params[:photo][:tags])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photo_url(@photo), notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    create_or_delete_posts_tags(@photo, params[:photo][:tags])

    respond_to do |format|
      if @photo.update(photo_params.except(:tags))
        format.html { redirect_to photo_url(@photo), notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def create_or_delete_posts_tags(photo, tags)
      photo.taggables.destroy_all # to remove existing taggables.
      tags = tags.strip.split(',')
      tags.each do |tag|
        photo.tags << Tag.find_or_create_by(name: tag)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:date, :title, :location, :description, :image, :tags)
    end
end
