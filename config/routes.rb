Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
    end
  end

  # namespace :api do
  #   namespace :v1 do
  #     namespace :merchants do
  #       get '/find', to: 'search#'
  #     end
  #   end
  # end
end
