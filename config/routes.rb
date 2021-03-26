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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
