Rails.application.routes.draw do

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
    root to: 'homes#top'
    get '/about' =>'homes#about'
    resources :items, only: [:show, :index]
    resources :addresses, only: [:index, :create, :update, :destroy, :edit]
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    post 'orders/confirm'
    get 'orders/complete'
    get '/customers/my_page', to: 'customers#show', as: 'customers'
    get 'customers/delete_verification'
    resources :customers, only: [:edit, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
  end

  namespace :admin do
    resources :orders, only: [:index, :update, :show]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :ordered_items, only: [:update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end