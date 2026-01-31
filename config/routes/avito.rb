namespace :avito do
  resources :settings, only: %i[index update]
end
