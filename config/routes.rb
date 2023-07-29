Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :qr_usages, only: [] do
        collection do
          get :check_usage
          get :can_create_qr
        end
      end
      
      resources :qr_codes do
        collection do
          get :all_user_qr_codes
        end
      end
      
      resources :posts
      
      # Add redirection route here
      get '/redirect/*random_server_url', to: 'qr_codes#redirect', format: false
    end
  end
end
