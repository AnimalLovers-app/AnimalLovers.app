Rails.application.routes.draw do

  namespace :public do
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/thanks'
    get 'orders/index'
    get 'orders/show'
  end
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
  end

# 管理者側のルーティング設定
  namespace :admin do
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
