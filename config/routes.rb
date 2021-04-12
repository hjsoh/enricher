Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'pages#home'


  # devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  # root to: "devise/sessions#new"

  # devise_scope :user do
  # end

  devise_scope :user do
    authenticated :user do
      root 'pages#home', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end


  #route for welcome email on register
  devise_for :users, :controllers => { :registrations => "registrations_added" }

  resources :office_hours, only: [ :index, :show, :edit, :destroy, :update ]
  resources :appointments, only: [ :index, :show, :edit, :destroy, :update ]

  resources :classrooms do
    resources :tickets, only: [ :index, :show, :new, :create]
    resources :messages, only: :create
    resources :announcements, only: [ :show, :new, :create, :destroy ]

    member do
      get :roster
      patch :roster_update
    end
  end

  resources :announcements, only: [ :index, :show, :new, :create, :destroy ]


  get 'chatrooms', to: 'classrooms#chatrooms'
  get '/chatrooms/:classroom_id', to: 'classrooms#show_chat', as: :show_chat

  resources :tickets, only: [ :index, :show, :edit, :destroy, :update ] do
    resources :comments, only: [ :new, :create ]
  end

  get "tickets/partial", to: "tickets#partial"

  patch "tickets/:id/done", to: "tickets#done"

  #API for classroom
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :classrooms, only: [ :index, :show, :update, :create ]
    end
  end
end
