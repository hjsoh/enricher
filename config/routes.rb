Rails.application.routes.draw do
  # mount ForestLiana::Engine => '/forest'
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  resources :classrooms do
    resources :tickets, only: [ :index, :show, :new, :create]
    resources :messages, only: :create

    member do
      get :roster
      patch :roster_update
    end
  end

  get 'chatrooms', to: 'classrooms#chatrooms'

  resources :tickets, only: [ :show ]

  #API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :classrooms, only: [ :index, :show ]
    end
  end
end
