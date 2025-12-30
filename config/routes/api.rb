namespace :api do
  namespace :v1, defaults: { format: :json } do
    post   :login,   to: 'auth/sessions#create'
    post   :refresh, to: 'auth/sessions#refresh'
    delete :logout,  to: 'auth/sessions#destroy'

    resources :users
    resources :orders

    get :not_found, to: 'application#not_found'
  end

  match '/*path', to: 'v1/application#not_found', via: :all
end
