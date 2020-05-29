# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  root :to => redirect('/publisher')

  get "/publisher" => "publisher#index", as: "publisher"
  get "/library" => "library#index", as: "library"
  get "/settings" => "settings#index", as: "settings"

  scope :publisher do
    resources :cards, only: [:index] do
      post :publish, on: :member
      post :draft, on: :member
    end

    namespace :cards do
      resources :stacked_inspiration_cards
      resources :overlay_inspiration_cards
      resources :pali_word_cards
    end
  end

  scope :library do
    namespace :artefacts do
      resources :excerpts
      resources :images
    end

    namespace :metadata do
      resources :authors
      resources :audiences
      resources :topics
    end
  end

  scope :settings do
    resources :users, controller: "users", only: [:index, :new, :create, :show] do
      resource :password, controller: "passwords", only: [:edit, :update]
    end
  end

  ######################
  ##    Clearance     ##
  ######################

  # We intentionally do not have a "sign up" flow. 
  # A new user must be created by an existing Admin User.
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

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
