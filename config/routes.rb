Rails.application.routes.draw do
  resources :contacts
  resources :wishlists
  resources :order_items
  resources :orders do 
    get :payment, on: :member
    post :create_charges, on: :member
    post :refund, on: :member
    get :track, on: :member
  end
  resources :carts
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_for :users
  # get 'home/index'
  #get '/categories/:category_id/brands/*id' => "brands#show"
  resources :categories do 
    resources :brands, only: [:show]
  end

  resources :brands, only: [:index]
  # resources :brands, only: [:show] 
  resources :products, only: [:show]
  resources :cart_items
  resources :addresses
  # resource :cart, only: [:show]
  # resources :order_items, only: [:create, :update, :destroy]
  get '/check_outs', to: 'cart_items#check_out'
  get '/review_and_payment', to: 'cart_items#review_and_payment'
  resources :charges
  get '*unmatched_route', to: 'application#not_found'

  root 'home#index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
