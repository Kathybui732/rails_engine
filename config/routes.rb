Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/revenue', to: 'revenue#index'

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'items/merchant#index'
      end

      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        get '/items', to: 'merchants/items#index'
        get '/revenue', to: 'revenue#show'
      end
    end
  end
end
