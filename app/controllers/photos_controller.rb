class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]

  # GET /photos or /photos.json
  def index
    @photos = Photo.all.order(date: :desc)
  end
  
  # GET /timeseries
  def timeseries
    # 'year' is the option to truncate the date to a year and filter by distinct (no duplicates)
    # therefore, we should only have a range from the early 1800s (I guess that's when the first photo was taken)
    # to present; therefore, it isn't too much to handle for Ruby to loop through in the .each method.
    @photos = Photo.select("date_trunc('year', date)").distinct.order(date_trunc: :desc)
  end

  # GET /timeseries/2024
  def timeseries_year
    start_year = Time.new(params[:id].to_i)

    # I added hash braces to avoid sql injection. I believe it would be safe without.
    # https://guides.rubyonrails.org/active_record_querying.html#hash-conditions
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

  def batch_upload
    @photo_batch = Photo.new
  end

  def batch_upload_create

    # Purpose: To learn how to upload batch photos / ActiveModels.
    #TODO: (1) add in error handling
    #TODO: (2) move to services controller (Business logic)
    #TODO: (3) convert to a background job using sidekiq.


    #@photos = params[:photo][:image] # ActionDispatch::Http::UploadedFile object

    @photos = photo_batch_params

    photo_title = @photos[:title]
    uploaded_files = @photos[:image] # An Array of ActionDispatch::Http::UploadedFile object (But the first element is an empty String)

    x = 0 # counter
    upload_errors = String.new

    uploaded_files.each do |file|      
      # For some reason there is an empty string in this Array, which causes 
      if file.is_a? ActionDispatch::Http::UploadedFile 
          photo = Photo.new

          x+=1
          puts "File number: #{x}"
          puts file.is_a? ActionDispatch::Http::UploadedFile
          photo[:title] = photo_title.to_s + "#{x}"
          photo.date = Time.new
          photo.image.attach(file)            # https://api.rubyonrails.org/v7.1.3.2/classes/ActiveStorage/Attached/One.html#method-i-attach

          if photo.save
            puts "photo number: #{file.original_filename.to_s} saved."
          else
            puts "photo number: #{file.original_filename.to_s} was not saved!"
            upload_errors.concat("photo: #{file.original_filename.to_s} was not saved!")
          end
      end
    end
  
    respond_to do |format|
      if upload_errors.empty?
        format.html { redirect_to upload_pictures_path, notice: "All photos were successfully uploaded." }
      else
        format.html { redirect_to upload_pictures_path, notice: upload_errors }
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

    def photo_batch_params
      params.require(:photo).permit(:title, image:[])
    end

end
