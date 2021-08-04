Rails.application.routes.draw do

  # 施設管理者用アカウント
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  registrations: 'admins/registrations'
  }

  # 会員用アカウント
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }

  # ログイン前のリンク先
  root "homes#top"
  get "/news" => "homes#news"
  get "/game" => "homes#game"

  # 会員（フォロー、フォロワー）
  resources :users, only:[:show, :edit, :update] do
    resources :relationship, only:[:create, :destroy]
    member do
      get :following, :followers
    end
  end

  # ダイレクトメッセージ
  resources :chats, only:[:show, :create]

  # 投稿
  resources :posts do
    resource :favorite_posts, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]
  end

  # バスケ施設（施設管理者側を分ける？）
  resources :facilities do
    resource :facility_favorites, only:[:create, :destroy]
    resources :facility_comments, only:[:create, :destroy]
  end

  #　バスケ施設予約
  resources :reserve_facilities, only:[:show, :create, :edit, :update, :destroy]

end
