Rails.application.routes.draw do
  resources :livros
  root 'livros#index'
end
