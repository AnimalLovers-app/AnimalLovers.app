Rails.application.routes.draw do

# 顧客側のルーティング設定
  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete :destroy_all
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      get "confirm", on: :collection
      get "thanks", on: :collection
    end
  end

# 管理者側のルーティング設定
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    root to: "homes#top"
    resources :items, only: [:new, :index, :show, :edit, :create, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

# deviseのルーティング設定
  devise_for :admin, skip: [:passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
}
#url名称を変更
 scope module: :public do
   get "customers/mypage" => "customers#show"
   get "customers/information/edit" => "customers#edit"
   patch "customers/information" => "customers#update"
    # ＃退会機能テスト用
  resources :customers, only: [:index]
 end

 scope module: :public do
  #退会機能画面
  get  'customers/unsubscribe' => 'customers#unsubscribe'
  # 論理削除用のルーティング
  patch 'customers/withdraw' => 'customers#withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end
end
