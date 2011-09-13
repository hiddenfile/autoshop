Autoshop::Application.routes.draw do

  resources :backcalls, :only => [:create]

  root :to => 'main_users#index'

  devise_for :admins, :controllers => { :sessions => "sessions" }
  devise_for :users, :controllers => { :sessions => "sessions" }

  resources :products

  resources :searches, :except => [:new, :update, :create, :destroy, :index, :show, :edit] do
    post 'search_by_products', :on => :member
  end

  match '/contacts' => 'contacts#index'

  #resources :orders, :only => [:show,:index,:create, :destroy]
  #resources :shop_carts,:except => [:new, :create, :index, :edit]
  resources :orders, :except => [:new, :update, :edit]
  resources :shop_carts,:only => [:update,:destroy,:show]

  resources :groups, :only => :show

  resources :companies, :only => :show do
    resources :groups, :only => :show do
      resources :products, :only => [:show,:index]
    end
  end

  match '/admin_panel' => 'admin_panel/users#index', :as => 'admin_users'

  namespace :admin_panel do
    resources :products, :companies , :groups, :users ,:admins, :contacts
    resources :photos, :only => [:index, :destroy]
    resources :orders, :only => [:index,:show,:update,:edit]
    resources :backcalls, :only => [:index, :destroy, :update]
  end
end
