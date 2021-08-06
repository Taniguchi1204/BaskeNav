Rails.application.routes.draw do

  get 'messages/show'
  get 'chats/show'
  get 'users/show'
  # 施設管理者用アカウント
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  registrations: 'admins/registrations'
  }

  # 会員用アカウント
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # ログイン前のリンク先
  root "homes#top"
  get "/news" => "homes#news"
  get "/game" => "homes#game"

  # 会員（フォロー、フォロワー）
  resources :users, only:[:show, :edit, :update] do
    resource :relationships, only:[:create,:destroy]
    get 'followings'     => 'relationships#followings'
    get 'followers'      => 'relationships#followers'
    get 'favorite_posts' => 'post_favorites#index'
  end

  # ダイレクトメッセージ
  resources :messages, only:[:show, :create]

  # 投稿
  resources :posts do
    resource :post_favorites, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]
  end

  # バスケ施設（施設管理者側を分ける？）
  resources :facilities do
    resource :facility_favorites, only:[:index, :create, :destroy]
    resources :facility_comments, only:[:create, :destroy]
  end

  #　バスケ施設予約
  resources :reserve_facilities, only:[:show, :create, :edit, :update, :destroy]

end
