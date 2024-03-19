Rails.application.routes.draw do

# 顧客側のルーティング設定
  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
  end

# 管理者側のルーティング設定
  namespace :admin do
    get 'homes/top'
  end

# deviseのルーティング設定
  devise_for :admin, skip: [:passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
  }

end
