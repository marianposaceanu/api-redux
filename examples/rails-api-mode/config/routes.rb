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
    resources :articles, only: %i[show update]
    resources :comments, only: :create
    resources :customers, only: :index
    resources :catalog, only: :index
    resources :devices, only: :create
    resources :diagnostics, only: :show
    resources :downloads, only: :show
    resources :events, only: :index
    resources :exports, only: :create
    resources :invoices, only: :show
    resources :libraries, only: [] do
      resources :books, only: %i[index show]
    end
    resources :operations, only: :show
    resources :orders, only: %i[index create show]
    resources :projects, only: %i[show destroy]
    resources :products, only: :show
    resources :registrations, only: :create
    resources :refunds, only: :create
    resources :searches, only: :index
    resource :profile, only: %i[show update], controller: :profile

    get "reports/finance", to: "reports#show"

    namespace :bulk do
      resources :customer_archives, only: :create
    end

    namespace :jwt do
      get :claims, to: "claims#show"
    end

    namespace :payments do
      resources :captures, only: :create
    end

    namespace :webhooks do
      resources :payments, only: :create
      resources :shipments, only: :create
    end
  end
end
