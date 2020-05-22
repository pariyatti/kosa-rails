class Cards::PaliWordCardsController < CardsController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  
  def index
    @cards = Card.all_for_editors(:pali_word)
  end
  
  def show
  end

  def new
    @card = Cards::PaliWordCard.new
  end

  def edit
  end

  def create
    @card = Cards::PaliWordCard.new_from_params(card_params)
    
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
