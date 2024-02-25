Rails.application.routes.draw do
  ###########################
  ### 管理者のルーティング ###
  ###########################

  # 認証機能
  # 新規登録とパスワードに関連する機能は作らない
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"  # ログイン用のルーティング
  }

  # namespaceはファイルの構成もURLも指定のパスにする
  namespace :admin do
    root to: 'homes#top'

    # genresコントローラ
    resources :genres, only: [:index, :create, :edit, :update]

    # itemsコントローラ
    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    # customersコントローラ
    resources :customers, only: [:index, :show, :edit, :update]

    # ordersコントローラ
    resources :orders, only: [:show, :update]
  end

  ###########################
  ###  顧客のルーティング  ###
  ###########################

  # 認証機能
  devise_for :customers, controllers: {
    registrations: "public/registrations", # 新規登録
    sessions: "public/sessions" # ログイン
  }

  # moduleはURLは変えずにファイルの構成だけ指定のパスにする
  scope module: :public do
    # homesコントローラ
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'

    # customersコントローラ
    get   'customers/my_page'          => 'customers#show',         as: 'customer'
    get   'customers/information/edit' => 'customers#edit',         as: 'edit_customer'
    get   'customers/unsubscribe'      => 'customers#unsubscribe',  as: 'unsubscribe_customer'  # 退会確認ページ
    patch 'customers/information'      => 'customers#update',       as: 'update_customer'
    patch 'customers/withdraw'         => 'customers#withdraw',     as: 'withdraw_customer'     # 退会処理

    # itemsコントローラ
    resources :items, only: [:index, :show]

    # addressesコントローラ
    resources :addresses, except: [:show, :new]

    # cart_itemsコントローラ
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, except: [:new, :edit, :show]

    # ordersコントローラ
    get 'orders/thanks'
    resources :orders, only: [:new, :index, :show, :create]
    post 'orders/confirm'
  end
end
