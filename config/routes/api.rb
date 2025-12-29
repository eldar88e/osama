namespace :api do
  namespace :v1, defaults: { format: :json } do
    post   :login,   to: 'users/sessions#create'
    post   :refresh, to: 'users/sessions#refresh'
    delete :logout,  to: 'users/sessions#destroy'
    get :not_found, to: 'application#not_found'

    resources :users
  end

  match '/*path', to: 'v1/application#not_found', via: :all
end
