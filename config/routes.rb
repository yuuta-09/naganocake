Rails.application.routes.draw do
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

  # moduleはURLは変えずにファイルの構成だけ指定のパスにする
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
  end
end
