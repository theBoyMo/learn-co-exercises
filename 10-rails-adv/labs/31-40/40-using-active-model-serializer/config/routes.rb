Rails.application.routes.draw do
  resources :authors, only: [:show, :index]
  resources :posts, only: [:index, :show, :new, :create, :edit]
  get 'posts/:id/post_data', to: 'posts#post_data'

  root to: 'posts#index'
end
