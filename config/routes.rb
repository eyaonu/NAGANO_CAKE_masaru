Rails.application.routes.draw do

  root "public/items#top"

# 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

scope module: :public do
    get 'items/top'
    resources :items, only: [:show]
    resources :addresses, only: [:index, :create, :update, :destroy, :edit]
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    get 'orders/verification'
    get 'orders/complete'
    get '/end_users', to: 'end_users#show', as: 'end_users'
    get 'end_users/delete_verification'
    resources :end_users, only: [:edit, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
  end

  namespace :admin do
    resources :orders, only: [:index, :update, :show]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :ordered_items, only: [:update]
  end

  resources :end_users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end