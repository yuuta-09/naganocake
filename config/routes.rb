Rails.application.routes.draw do
  get 'genres/index'
  get 'genres/edit'
  ###########################
  ### 管理者のルーティング ###
  ###########################

  # 認証機能
  # 新規登録とパスワードに関連する機能は作らない
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"  # ログイン用のルーティング
  }

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
  end
end
