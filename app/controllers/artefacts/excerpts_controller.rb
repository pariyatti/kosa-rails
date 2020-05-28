class Artefacts::ExcerptsController < LibraryController
  before_action :set_excerpt, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  
  # GET /excerpts
  # GET /excerpts.json
  def index
    @excerpts = Artefacts::Excerpt.all
  end

  # GET /excerpts/1
  # GET /excerpts/1.json
  def show
  end

  # GET /excerpts/new
  def new
    @excerpt = Artefacts::Excerpt.new
  end

  # GET /excerpts/1/edit
  def edit
  end

  # POST /excerpts
  # POST /excerpts.json
  def create
    @excerpt = Artefacts::Excerpt.new(excerpt_params)

    respond_to do |format|
      if @excerpt.save
        format.html { redirect_to @excerpt, notice: 'Excerpt was successfully created.' }
        format.json { render :show, status: :created, location: @excerpt }
      else
        format.html { render :new }
        format.json { render json: @excerpt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /excerpts/1
  # PATCH/PUT /excerpts/1.json
  def update
    respond_to do |format|
      if @excerpt.update(excerpt_params)
        format.html { redirect_to @excerpt, notice: 'Excerpt was successfully updated.' }
        format.json { render :show, status: :ok, location: @excerpt }
      else
        format.html { render :edit }
        format.json { render json: @excerpt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /excerpts/1
  # DELETE /excerpts/1.json
  def destroy
    @excerpt.destroy
    respond_to do |format|
      format.html { redirect_to artefacts_excerpts_url, notice: 'Excerpt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excerpt
      @excerpt = Artefacts::Excerpt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def excerpt_params
      params.require(:artefacts_excerpt).permit(:url, :reference, :content)
    end
end
