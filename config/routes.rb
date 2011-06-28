Avtoportal::Application.routes.draw do

  devise_for :users

  namespace :admin do
    resources :products, :companies , :groups, :users
  end
end
