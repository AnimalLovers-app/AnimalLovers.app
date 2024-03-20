Rails.application.routes.draw do

  namespace :admin do
    get 'homes/top'
  end


  devise_for :admin, skip: [:passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  # devise_for :customers
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 会員側のルーティング設定
  scope module: :public do
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end
  # resources :addresses, only: [:index, :edit, :create, :update, :destroy]
end
