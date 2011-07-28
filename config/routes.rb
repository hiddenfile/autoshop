Autoshop::Application.routes.draw do

  root :to => 'main_users#index'

  resources :products, :except => [:new, :update, :create, :destroy]
  resources :orders, :only => [:show,:index] do
    get 'cancel', :on => :member
    get 'accept', :on => :member
    get 'remove', :on => :member
  end
  resources :shop_carts,:only => [:index] do
    get 'add_to_cart', :on => :member
    get 'remove_from_cart', :on => :member
  end
  resources :groups, :only => :show

  match '/admin_panel' => 'admin_panel/users#index', :as => 'admin_users'

  devise_for :admin
  devise_for :users

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
