Autoshop::Application.routes.draw do

  root :to => 'main_users#index'

  resources :backcalls, :only => [:create, :index]

  devise_for :admins, :controllers => { :sessions => "sessions" }
  devise_for :users, :controllers => { :sessions => "sessions" }

  resources :products

  resources :searches, :only => [] do
    post 'search_by_products', :on => :collection
  end

  resources :orders, :except => [:new, :update, :edit]
  resources :shop_carts,:only => [:update,:destroy]
  match 'shop_cart' => "shop_carts#show", :as => 'shop_cart', :via => 'get'

  resources :groups, :only => :show
  resources :custom_views, :only => :index

  resources :companies, :only => :show do
    resources :groups, :only => :show do
      resources :products, :only => [:show,:index]
    end
  end

  match '/admin_panel' => 'admin_panel/users#index', :as => 'admin_users'

  namespace :admin_panel do
    resources :products, :companies , :groups, :users ,:admins, :custom_views
    resources :photos, :only => [:index, :destroy]
    resources :orders, :only => [:index,:show,:update,:edit]
    resources :backcalls, :only => [:index, :destroy, :update]
    resources :order_items, :only => [:create, :update,:destroy]
  end
end
