Autoshop::Application.routes.draw do

  root :to => 'main_users#index'

  devise_for :admins, :controllers => { :sessions => "sessions" }
  devise_for :users, :controllers => { :sessions => "sessions" }

  resources :products, :except => [:new, :update, :create, :destroy] do
    get 'search', :on => :member
  end
  resources :orders, :only => [:show,:index] do
    get 'cancel', :on => :member
    get 'accept', :on => :member
    get 'remove', :on => :member
  end
  resources :shop_carts,:except => [:new, :update, :create, :destroy, :index, :show, :edit] do
    get 'add_to_cart_update_cart_and_table', :on => :member
    get 'add_to_cart_update_cart', :on => :member
    get 'remove_from_cart', :on => :member
    get 'cart_items', :on => :member
  end
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
