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
    resources :customers, only: :index
    resources :catalog, only: :index
    resources :libraries, only: [] do
      resources :books, only: %i[index show]
    end
    resources :orders, only: %i[index create show]
    resources :registrations, only: :create
    resource :profile, only: %i[show update], controller: :profile

    get "reports/finance", to: "reports#show"

    namespace :jwt do
      get :claims, to: "claims#show"
    end

    namespace :payments do
      resources :captures, only: :create
    end
  end
end
