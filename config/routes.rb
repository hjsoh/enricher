Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  devise_scope :user do
    authenticated :user do
      root 'pages#home', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  resources :office_hours, only: [ :index, :show, :edit, :destroy, :update ]
  resources :appointments, only: [ :index, :show, :edit, :destroy, :update ]

  resources :classrooms do
    resources :tickets, only: [ :index, :show, :new, :create]
    resources :messages, only: :create

    member do
      get :roster
      patch :roster_update
    end
  end

  resources :tickets, only: [ :index, :show, :edit, :destroy, :update ] do
    resources :comments, only: [ :new, :create ]
  end

  patch "tickets/:id/done", to: "tickets#done"

  #API for classroom
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :classrooms, only: [ :index, :show, :update, :create ]
    end
  end
end
