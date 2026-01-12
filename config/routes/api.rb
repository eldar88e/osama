namespace :api do
  namespace :v1, defaults: { format: :json } do
    post   :login, to: 'auth/sessions#create'
    post   :refresh_token, to: 'auth/sessions#refresh'
    delete :logout, to: 'auth/sessions#destroy'

    resources :users, except: %i[new edit]
    resources :orders, except: %i[new edit] do
      resources :order_items, only: %i[index create update destroy] do
        resources :order_item_performers, only: %i[create update destroy]
      end
    end
    resources :cars, except: %i[new edit]
    resources :contractors, except: %i[new edit]
    resources :services, except: %i[new edit]

    get :not_found, to: 'application#not_found'
  end

  match '/*path', to: 'v1/application#not_found', via: :all
end
