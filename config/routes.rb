Rails.application.routes.draw do

# 顧客側のルーティング設定
  scope module: :public do
    root to: 'homes#top'
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
    root to: "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :items, only: [:new, :index, :show, :edit, :update, :create]
  end

# deviseのルーティング設定
  devise_for :admin, skip: [:passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
