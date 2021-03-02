Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "home/about" => "homes#about"
  resources :users, only:[:show, :index, :edit, :update]
  resources :books, only:[:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only:[:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end
