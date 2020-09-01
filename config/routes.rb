Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'items/merchant#index'
      end

      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        get '/items', to: 'merchants/items#index'
      end
    end
  end

  # namespace :api do
  #   namespace :v1 do
  #     namespace :merchants do
  #       resources :items, only: [:index]
  #       # get '/find', to: 'search#'
  #     end
  #   end
  # end
end
