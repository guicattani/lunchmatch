Rails.application.routes.draw do
  root to: 'home#index', as: :home

  namespace :api do
    namespace :v1 do
      resources :employees, only: [:index, :create]
      resources :departments, only: [:index, :create]
      resources :rounds, only: [:index, :create]
    end
  end

end