Avtoportal::Application.routes.draw do

  match '/products' => 'products#index'

  resource :product,:except => :show do
    collection do
     match '/show/:id' => 'products#show' , :as => 'show'
    end
  end

#  root :to => 'admin/admins#index', :constraints => {}
  root :to => 'products#index'

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



end
