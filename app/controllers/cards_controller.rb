class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all_for_editors
  end

  def show
    raise "Do not show cards using the `Card` superclass."
  end

  def new
    raise "Do not create new `Card` objects directly. Use the subtypes."
  end

  def edit
    raise "Do not edit `Card` objects directly. Use the subtypes."
  end

  def create
    raise "Do not create `Card` objects directly. Use the subtypes."
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def default_card_params
    [:card_type, :published, :bookmarkable, :shareable, :header]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end
  
  private

    # Only allow a list of trusted parameters through.
    def card_params
      raise "`card_params` must be overloaded in each controller."
    end

end
