namespace :admin do
  get '/', to: '/analytics#index'

  resources :users
end
