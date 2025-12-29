namespace :api do
  namespace :v1 do
    post   :login,   to: 'users/sessions#create'
    post   :refresh, to: 'users/sessions#refresh'
    delete :logout,  to: 'users/sessions#destroy'

    defaults format: :json do
      resources :users
    end
  end
end
