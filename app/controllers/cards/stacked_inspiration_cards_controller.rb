class Cards::StackedInspirationCardsController < CardsController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  
  def show
  end

  def new
    @card = Cards::StackedInspirationCard.new

    if params[:image_id]
      @image_chosen = Artefacts::Image.find(params[:image_id])
    else
      @image_artefacts = Artefacts::Image.all
      @image_artefacts.each(&:reload_from_database!)
    end
  end

  def edit
  end

  def create
    @card = Cards::StackedInspirationCard.new_from_params(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def card_params
      allowed = default_card_params.push(:image, :text, :image_filename)
      params.require(:cards_stacked_inspiration_card).permit(*allowed)
    end
end
