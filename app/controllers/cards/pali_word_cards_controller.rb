class Cards::PaliWordCardsController < CardsController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @card = Cards::PaliWordCard.new
  end

  def edit
  end

  def create
    # TODO: HACK: this is just to get the screen and API working
    #             ...figure out lists tomorrow. -sd
    translation_params = card_params.slice(:language, :translation)
    @translation = Cards::PaliWordTranslation.create(translation_params)

    new_card_params = card_params.slice(*default_card_params.push(:pali))
    @card = Cards::PaliWordCard.new_from_params(new_card_params)
    @card.pali_word_translations = [@translation]

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
      allowed = default_card_params.push(:pali, :language, :translation)
      params.require(:cards_pali_word_card).permit(*allowed)
    end
end
