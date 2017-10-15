Rails.application.routes.draw do
  root 'static_pages#home'
  get 'signup', to: 'contractors#new', as: :contractor_sign_up

  resources :contractors, only: [:create, :show]
end