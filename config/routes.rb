Autoshop::Application.routes.draw do

  resources :products, :except => [:new, :update, :create, :destroy]
  resources :groups, :only => :show
#  root :to => 'admin/admins#index', :constraints => {}
  root :to => 'main_users#index'
  match '/adminroot' => 'admin_panel/admins#index', :as => 'adminroot'
  match '/admin_panel' => 'admin_panel/users#index', :as => 'admin_users'

  devise_for :admin

#  devise_scope :admin do
#    get '/login' => 'devise/sessions#new'
#    get '/logout' => 'devise/sessions#destroy'
#  end


  devise_for :users

#  resource :  #,:except => :show do
#    collection do
#      get :show ,:as => "product"
#    end
#  end

  namespace :admin_panel do
    resources :products, :companies , :groups, :users ,:admins
  end

  scope '/delete_photo' do
   match 'product/:product_id/:photo_id' => "admin_panel/products#delete_photo", :as => :delete_product_photo
   match 'company/:company_id/:photo_id' => "admin_panel/companies#delete_photo", :as => :delete_company_photo
   match 'group/:group_id/:photo_id' => "admin_panel/groups#delete_photo", :as => :delete_group_photo
  end

end
