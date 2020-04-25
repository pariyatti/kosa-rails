# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  resources :excerpts
  resources :image_assets

  resources :audiences
  resources :topics
  resources :authors

  resources :cards, only: [:index] do
    post :publish, on: :member
    post :draft, on: :member
  end

  namespace :cards do
    resources :stacked_inspiration_cards
    resources :overlay_inspiration_cards
    resources :pali_word_cards
  end

  root 'application#index'

  scope :api, module: 'api' do
    get '/today', to: 'today#index'

    resources :topics, only: [:index, :show]
  end
end
