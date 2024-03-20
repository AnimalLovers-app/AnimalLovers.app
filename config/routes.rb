Rails.application.routes.draw do

  namespace :admin do
    get 'homes/top'
    resources :customers, only: [:index, :show, :edit, :update]
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

  # 顧客側/配送先一覧・編集のルーティング設定
  scope module: :public do
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  #管理者側/顧客一覧・詳細・編集のルーティング設定
  # namespace :admin do
  #   get 'customers/index'
  #   get 'customers/show'
  #   get 'customers/edit'
  # end


end
