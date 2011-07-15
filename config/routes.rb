Avtoportal::Application.routes.draw do

  match '/products' => 'products#index'


  resource :product,:except => :show do
    collection do
     match '/show/:id' => 'products#show' , :as => 'show'
    end
  end

#  root :to => 'admin/admins#index', :constraints => {}
  root :to => 'products#index'
  match '/adminroot' => 'admin_panel/admins#index', :as => 'adminroot'

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
    resources :companies , :groups, :users ,:admins
    resources :products
  end

  scope '/delete_photo' do
   match '/:product_id/:photo_id' => "admin_panel/products#delete_photo", :as => :delete_product_photo
  end

end
