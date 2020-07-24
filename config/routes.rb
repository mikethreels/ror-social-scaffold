Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  post 'invite', to: 'users#invite'
  get 'invitation', to: 'users#invitation'
  post 'accept', to: 'users#accept'
  post 'ignore', to: 'users#ignore'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
