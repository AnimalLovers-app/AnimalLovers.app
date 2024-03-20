Rails.application.routes.draw do

  # namespace :public do
  #   get 'customers/show'
  #   get 'customers/edit'
  # end

  namespace :admin do
    get 'homes/top'
  end

 #url名称を変更
 scope module: :public do
   get "customers/mypage" => "customers#show"
   get "customers/information/edit" => "customers#edit"
   patch "customers/information" => "customers#update"
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
end
