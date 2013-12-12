Vizibid::Application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :forms
  resources :comments
  resources :form_requests
  resources :form_ratings
  resources :user_details
  resources :user_notifications
  resources :user_feedbacks, only: [:new, :create]
  resources :inappropriate_documents, only: [:create]
  resources :inappropriate_requests, only: [:create]
  resources :password_resets

  root :to => 'pages#home'

  match 'password_resets/new' => 'password_resets#new', :via => :get
  match '/faq' => 'pages#faq'
  match '/learn_more/' => 'pages#learnmore', :as => :learn_more_base
  match '/learn_more/:path' => 'pages#learnmore', :as => :learn_more
  match '/support' => 'pages#support'
  match '/privacy_policy' => 'pages#privacy_policy'
  match '/terms_of_use' => 'pages#terms_of_use'
  match '/why' => 'pages#why'
  match '/requestcenter' => 'pages#requestcenter'
  match '/history' => 'pages#history'
  match '/share' => 'pages#share'
  match '/feedback' => 'pages#feedback'
  match '/signup' => 'users#new'
  match '/uploadpage' => 'forms#upload_special', :via => :get
  match '/settings' => redirect('/settings/account')
  match '/settings/:path' => 'pages#settings', :as => :settings
  match '/download' =>'forms#download', :via => :get
  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy', :via => :delete
  match '/completerequest/:id' => 'form_requests#completerequest', :as => :completerequest
  match '/completerequestfrompage/:id' => 'form_requests#completerequestfrompage', :as => :completerequestfrompage
  match '/form_requests/edit/:id/:comment' => 'form_requests#edit', :as => :requestcomment
  match '/deleteresponse/:id' => 'form_requests#destroy_response', :as => :deleteresponse
  match '/verify/:id' => 'users#verify', :as => :verify
  match '/deleteforumcomment/:id' => 'forum_comments#delete_forum_comment', :as => :deleteforumcomment
  match '/practicearea' => 'user_practice_areas#update', :via => :post, :as => :practicearea
  match '/follow/:id' => 'form_follows#update', :via => :get, :as => :followform
  match '/unfollow/:id' => 'form_follows#unfollow', :via => :get, :as => :unfollowform
  match '/approveresponse/:id' => 'form_requests#approveresponse', :via => :get, :as => :approveresponse
  match '/share/:id' => 'shared_forms#create', :via => :post, :as => :share

  match ':name' => 'users#show', :as => :usershow
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
