# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  namespace :artefacts do
    resources :excerpts
    resources :images
  end

  namespace :metadata do
    resources :authors
    resources :audiences
    resources :topics
  end

  namespace :cards do
    resources :stacked_inspiration_cards
    resources :overlay_inspiration_cards
    resources :pali_word_cards
  end

  resources :cards, only: [:index] do
    post :publish, on: :member
    post :draft, on: :member
  end

  scope :api, module: 'api' do
    get '/today', to: 'today#index'
  end

  root 'application#index'

end
