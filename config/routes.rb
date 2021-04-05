Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'pages#home'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :office_hours, only: [ :index, :show, :edit, :destroy, :update ]
  resources :appointments, only: [ :index, :show, :edit, :destroy, :update ]

  get 'announcements', to: 'announcements#index'

  resources :classrooms do
    resources :tickets, only: [ :index, :show, :new, :create]
    resources :messages, only: :create
    resources :announcements, only: [ :show, :new, :create, :destroy ]

    member do
      get :roster
      patch :roster_update
    end
  end


  get 'chatrooms', to: 'classrooms#chatrooms'

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
