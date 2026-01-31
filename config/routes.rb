Rails.application.routes.draw do
  root 'analytics#index'

  devise_for :users

  # get 'up' => 'rails/health#show', as: :rails_health_check

  authenticate :user do
    mount SolidQueueDashboard::Engine, at: '/solid-queue'
    # mount PgHero::Engine, at: '/pghero'
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :cars
  resources :settings
  resources :users
  resources :services
  resources :analytics, only: :index
  resources :orders

  namespace :webhooks do
    resources :telegram, only: :create
    resource :avito, only: :create
  end

  draw :admin
  draw :api
  draw :avito
end
