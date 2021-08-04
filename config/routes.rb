Rails.application.routes.draw do
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  registrations: 'admins/registrations'
}
devise_for :users, controllers: {
  sessions:      'users/sessions',
  registrations: 'users/registrations'
}
  root "homes#top"
  get "/news" => "homes#news"
  get "/game" => "homes#game"

  resources :users, only:[:show, :edit, :update] do
    member do
      get :following, :followers
    end
  end

  resources :relationship, only:[:create, :destroy]
  resources :chats, only:[:show, :create]
  resources :posts do
    resource :favorite_posts, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]
  end

  resources :facilities, only:[:index, :show] do
    resource :facility_favorites, only:[:create, :destroy]
    resources :facility_comments, only:[:create, :destroy]
  end

  resources :reserve_facilities, only:[:show, :create, :edit, :update, :destroy]
  
  resources :post_facilities, only:[:new,:create,:edit,:update,:destroy]




end
