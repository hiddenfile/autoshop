Autoshop::Application.routes.draw do

  root :to => 'main_users#index'

  devise_for :admins, :controllers => { :sessions => "sessions" }
  devise_for :users, :controllers => { :sessions => "sessions" }

  resources :products, :except => [:new, :update, :create, :destroy] do
    get 'search', :on => :member
  end
  resources :orders, :only => [:show,:index,:create, :destroy]
  resources :shop_carts,:except => [:new, :update, :create, :index, :edit]
  resources :shop_cart_items, :only => [:create,:destroy]
  resources :groups, :only => :show

  match '/admin_panel' => 'admin_panel/users#index', :as => 'admin_users'

  namespace :admin_panel do
    resources :products, :companies , :groups, :users ,:admins
    resources :photos, :only => [:index, :destroy]
  end

  resources :companies do
    resources :groups do
      resources :products
    end
  end
end
