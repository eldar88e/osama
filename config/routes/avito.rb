namespace :avito do
  resource :settings, only: %i[show update]
end
