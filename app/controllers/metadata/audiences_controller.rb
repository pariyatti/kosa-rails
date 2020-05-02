class Metadata::AudiencesController < ApplicationController
  before_action :set_audience, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  
  # GET /audiences
  # GET /audiences.json
  def index
    @audiences = Metadata::Audience.all
  end

  # GET /audiences/1
  # GET /audiences/1.json
  def show
  end

  # GET /audiences/new
  def new
    @audience = Metadata::Audience.new
  end

  # GET /audiences/1/edit
  def edit
  end

  # POST /audiences
  # POST /audiences.json
  def create
    @audience = Metadata::Audience.new(audience_params)

    respond_to do |format|
      if @audience.save
        format.html { redirect_to @audience, notice: 'Audience was successfully created.' }
        format.json { render :show, status: :created, location: @audience }
      else
        format.html { render :new }
        format.json { render json: @audience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /audiences/1
  # PATCH/PUT /audiences/1.json
  def update
    respond_to do |format|
      if @audience.update(audience_params)
        format.html { redirect_to @audience, notice: 'Audience was successfully updated.' }
        format.json { render :show, status: :ok, location: @audience }
      else
        format.html { render :edit }
        format.json { render json: @audience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audiences/1
  # DELETE /audiences/1.json
  def destroy
    @audience.destroy
    respond_to do |format|
      format.html { redirect_to metadata_audiences_url, notice: 'Audience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audience
      @audience = Metadata::Audience.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def audience_params
      params.require(:metadata_audience).permit(:name)
    end
end
