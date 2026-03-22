Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "root#show"

  resources :orders, only: %i[index show]
  resources :widgets, only: %i[index create show] do
    get :export, on: :member
  end

  post "/sessions", to: "sessions#create"

  namespace :oauth do
    post :token, to: "tokens#create"
  end

  namespace :v0 do
    resources :appointments, only: :index
  end

  namespace :v1 do
    resources :appointments, only: :index
    resources :catalog, only: :index
    resources :orders, only: %i[index create show]

    namespace :jwt do
      get :claims, to: "claims#show"
    end

    namespace :payments do
      resources :captures, only: :create
    end
  end
end
