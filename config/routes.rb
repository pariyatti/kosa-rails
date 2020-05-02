# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  root 'application#index'

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


  #################
  ##  Clearance  ##
  #################

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"


  ########################
  ##  Custom Clearance  ##
  ########################

  resources :users, controller: "users", only: [:index, :new, :create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  # We intentionally do not have a "sign up" flow. A new user must be created by
  # an existing Admin User.
  # get "/sign_up" => "users#new", as: "sign_up"


  ######################
  ##  Mobile App API  ##
  ######################

  namespace :api, module: 'api' do
    # Please only bump versions for a new release to the public.
    # If we do this right we'll only have two versions: v1 and v2.
    namespace :v1 do
      get '/today', to: 'today#index'
    end
  end

end
