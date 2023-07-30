Rails.application.routes.draw do
  root to: 'home#index', as: :home

  namespace :api do
    namespace :v1 do
      resources :home, only: [:index]
    end
  end

end