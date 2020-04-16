class ImageAssetsController < ApplicationController
  before_action :set_image_asset, only: [:show, :edit, :update, :destroy]

  def index
    @image_assets = ImageAsset.all
    @image_assets.each(&:reload_from_database!)
  end

  def show
  end

  def new
    @image_asset = ImageAsset.new
  end

  def edit
  end

  def create
    @image_asset = ImageAsset.new()
    @image_asset.image = image_asset_params[:image_file]

    respond_to do |format|
      if @image_asset.save
        format.html { redirect_to @image_asset, notice: 'Image was successfully added.' }
        format.json { render :show, status: :created, location: @image_asset }
      else
        format.html { render :new }
        format.json { render json: @image_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_params = image_asset_params.merge({ image: image_asset_params[:image_file] })
    respond_to do |format|
      if @image_asset.update(update_params)
        format.html { redirect_to @image_asset, notice: 'image_asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_asset }
      else
        format.html { render :edit }
        format.json { render json: @image_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image_asset.destroy
    respond_to do |format|
      format.html { redirect_to image_assets_url, notice: 'image_asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
  def set_image_asset
    @image_asset = ImageAsset.find(params[:id])
  end

  def image_asset_params
    params.require(:image_asset).permit(:image_file)
  end

end
