Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :classrooms do
    resources :tickets, only: [ :index, :show, :new, :create]

    member do
      get :roster
      patch :roster_update
    end
  end

  resources :tickets, only: [ :show ]

  #API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :classrooms, only: [ :index ]
    end
  end
end
