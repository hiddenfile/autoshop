Autoshop::Application.routes.draw do
  resources :products, :except => [:new, :update, :create, :destroy]
  resources :groups, :only => :show
  root :to => 'main_users#index'
  match '/admin_panel' => 'admin_panel/users#index', :as => 'admin_users'

  devise_for :admin
  devise_for :users
  namespace :admin_panel do
    resources :products, :companies , :groups, :users ,:admins
    resources :photos, :only => [:index, :destroy]
  end
end
