Rails.application.routes.draw do
  resources :livros
  root 'livros#index'
  namespace :api do
    namespace :v1 do
      resources :livros
    end
  end
end
