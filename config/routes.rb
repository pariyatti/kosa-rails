# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  resources :excerpts
  resources :audiences
  resources :cards
  resources :topics
  resources :authors

  root 'application#index'

  scope :api, module: 'api' do
    get '/today', to: 'today#index'

    resources :topics, only: [:index, :show]
  end
end
