Rails.application.routes.draw do

  devise_for :users, :path => '',
                      controllers: {
                        registrations: "devise/registrations"
                      },
                     :path_names => {
                     :sign_in => 'login',
                     :sign_out => 'logout',
                     :sign_up => 'register'
                     }
  resources :users
  authenticated :user do
    root 'posts#index', as: :authenticated_root
  end
  root 'static_pages#home'

  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  resources :posts do
    resources :comments, :only => [:create, :destroy]
  end

  post 'posts/:id/upvote' => 'posts#upvote', as: "upvote"
  post 'posts/:id/downvote' => 'posts#downvote', as: "downvote"

  post 'comments/:id/upvote' => 'comments#upvote', as: "comment_upvote"
  post 'comments/:id/downvote' => 'comments#downvote', as: "comment_downvote"
  post 'comments/:id/reply_box' => 'comments#reply_box', as: "reply_box"
  post 'comments/:id/reply_post' => 'comments#reply_post', as: "reply_post"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'application#hello'

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
