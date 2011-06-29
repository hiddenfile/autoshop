Avtoportal::Application.routes.draw do

  root :to => 'admin/admins#index', :constraints => {}

  devise_for :admins

  devise_for :users

  namespace :admin do
    resources :products, :companies , :groups, :users ,:admins
  end
end
