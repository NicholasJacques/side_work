Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'signup', to: 'contractors#new', as: :contractor_sign_up
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'

  resources :contractors, only: [:create, :show]
end