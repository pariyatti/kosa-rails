# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  root :to => redirect('/publisher')

  get "/publisher" => "publisher#index", as: "publisher"
  get "/library" => "library#index", as: "library"
  get "/settings" => "settings#index", as: "settings"

  #################
  ##  Publisher  ##
  #################

  resources :cards, only: [:index] do
    post :publish, on: :member
    post :draft, on: :member
  end

  #################
  ##   Library   ##
  #################

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


  #################
  ##  Settings   ##
  #################


  #################
  ##  Clearance  ##
  #################

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:index, :new, :create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  # We intentionally do not have a "sign up" flow. 
  # A new user must be created by an existing Admin User.
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"


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
