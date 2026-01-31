namespace :admin do
  get '/', to: '/analytics#index'

  resources :users

  draw :avito
end
