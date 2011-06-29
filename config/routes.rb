Avtoportal::Application.routes.draw do

#  root :to => 'admin/admins#index', :constraints => {}
  root :to => 'products#index'

  devise_for :admin

#  devise_scope :admin do
#    get '/login' => 'devise/sessions#new'
#    get '/logout' => 'devise/sessions#destroy'
#  end


  devise_for :users

  namespace :admin_panel do
    resources :products, :companies , :groups, :users ,:admins
  end

  resource :products
end
