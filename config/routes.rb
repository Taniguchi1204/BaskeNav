Rails.application.routes.draw do

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
  post "/guest_sign_in"  => "users#new_guest"
  get  "/search_users"   => "users#search_users"
  get  "/news"           => "homes#news"
  get  "/game"           => "homes#game"


  # 会員（フォロー、フォロワー）
  resources :users, only:[:show, :edit, :update] do
    resource :relationships, only:[:create,:destroy]
    get 'favorite_posts'      => 'post_favorites#index'
    get 'favorite_facilities' => 'facility_favorites#index'
  end

  # ダイレクトメッセージ
  resources :messages, only:[:create]

  # 投稿
  resources :posts do
    delete 'trash_box'        => 'post#trash_box'
    resource :post_favorites, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]
  end

  # バスケ施設
  resources :facilities do
    resource :facility_favorites, only:[:index, :create, :destroy]
    resources :facility_comments, only:[:create, :destroy]
    #　バスケ施設予約
    resources :reserve_facilities, only:[:update, :create, :destroy]
  end

end
