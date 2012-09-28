Vizibid::Application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :forms
  resources :comments, only: [:create, :destroy]
  resources :form_requests
  resources :form_ratings
  resources :user_details
  resources :user_notifications
  resources :user_feedbacks, only: [:new, :create]
  resources :inappropriate_documents, only: [:create]

  root :to => 'pages#home'

  match '/about' => 'pages#about'
  match '/requestcenter' => 'pages#requestcenter'
  match '/history' => 'pages#history'
  match '/share' => 'pages#share'
  match '/feedback' => 'pages#feedback'
  match '/signup' => 'users#new'
  match '/settings' => redirect('/settings/account')
  match '/settings/:path' => 'pages#settings', :as => :settings
  match '/download' =>'forms#download', :via => :get
  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy', :via => :delete
  match '/completerequest/:id' => 'form_requests#completerequest', :as => :completerequest
  match '/form_requests/edit/:id/:comment' => 'form_requests#edit', :as => :requestcomment
  #match '/inappropriate_documents/:formid' => 'inappropriate_documents#create', :as => :inappropriate_document

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
