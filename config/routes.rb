Rails.application.routes.draw do
  
  resources :userreviews
  #devise_for :sessions, :controllers => {:sessions => "sessions"}
  devise_for :userlogins, :controllers => {:userlogins => "userlogins", :sessions => "sessions", :registrations => "registrations"} do
   # collection do
   #   get 'search'
   # end
  end
  #devise_for :userlogins
  resources :courses
  resources :skills
  resources :users
  resources :userlogins do
    collection do 
      get 'search'
    end 
  end

# conversations
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

resources :favorite_userlogins, only: [:create, :destroy]

  get 'pages/Home'

  get 'pages/FAQ'

  get 'pages/Messaging'

  get 'pages/Favorites'

  get 'pages/Error'

  get 'pages/Profile_Setup'

  get 'pages/User_Profile/:id' => 'pages#User_Profile' , :id => 'id'
  
  get 'ContactUs', to: 'helps#new', as: 'contact'

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  post 'ContactUs', to: 'helps#create'
  
  post '/rate' => 'rater#create', :as => 'rate'

  root 'pages#Home'

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
