Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "short_urls#index"

  resources :short_urls, only: :create do
    member do 
      get '/stats', to: "short_urls#stats"
    end
  end

end
