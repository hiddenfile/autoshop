Autoshop::Application.routes.draw do

  root :to => 'main_users#index'

  devise_for :admins, :controllers => { :sessions => "sessions" }
  devise_for :users, :controllers => { :sessions => "sessions" }

  resources :searches, :except => [:new, :update, :create, :destroy, :index, :show, :edit] do
    get 'search_by_products', :on => :member
  end
  resources :products, :except => [:new, :update, :create, :destroy]
  resources :orders, :only => [:show,:index,:create, :destroy]
  resources :shop_carts,:except => [:new, :update, :create, :index, :edit] do
    get 'add_to_cart', :on => :member
    get 'remove_from_cart', :on => :member
  end
  resources :groups, :only => :show

  match '/admin_panel' => 'admin_panel/users#index', :as => 'admin_users'

  namespace :admin_panel do
    resources :products, :companies , :groups, :users ,:admins
    resources :photos, :only => [:index, :destroy]
    resources :orders, :only => [:index,:show,:update,:edit]
  end

  resources :companies do
    resources :groups do
      resources :products
    end
  end
end
