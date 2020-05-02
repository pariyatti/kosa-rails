class Artefacts::ImagesController < ApplicationController
  before_action :set_image_artefact, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    @image_artefacts = Artefacts::Image.all
    @image_artefacts.each(&:reload_from_database!)
  end

  def show
  end

  def new
    @image_artefact = Artefacts::Image.new
  end

  def edit
  end

  def create
    @image_artefact = Artefacts::Image.new()
    @image_artefact.image = image_artefact_params[:image_file]

    respond_to do |format|
      if @image_artefact.save
        format.html { redirect_to @image_artefact, notice: 'Image was successfully added.' }
        format.json { render :show, status: :created, location: @image_artefact }
      else
        format.html { render :new }
        format.json { render json: @image_artefact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_params = image_artefact_params.merge({ image: image_artefact_params[:image_file] })
    respond_to do |format|
      if @image_artefact.update(update_params)
        format.html { redirect_to @image_artefact, notice: 'image_artefact was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_artefact }
      else
        format.html { render :edit }
        format.json { render json: @image_artefact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image_artefact.destroy
    respond_to do |format|
      format.html { redirect_to artefacts_images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
  def set_image_artefact
    @image_artefact = Artefacts::Image.find(params[:id])
  end

  def image_artefact_params
    params.require(:artefacts_image).permit(:image_file)
  end

end
