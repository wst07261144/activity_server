ActivityServer::Application.routes.draw do

  resource :users

  get "user/register"
  get "user/login"
  get "user/login_success"
  get "user/reset_key1_check_account"
  get "user/reset_key2_check_question"
  get "user/reset_key3_to_reset_key"
  get "user/manage_index",:as => "manage_index"
  get "user/add_account"
  get "user/:id/admin_modify_account_key"=>"user#admin_modify_account_key" ,:as=>"admin"

  post "user/login" => 'user#handle_login'
  post "user/register"=>'user#judge_input_legal'
  post "user/reset_key1_check_account"=>'user#handle_reset_key1'
  post "user/reset_key2_check_question"=>'user#handle_reset_key2'
  post "user/reset_key3_to_reset_key"=>'user#handle_reset_key3'
  post "user/add_account"=>"user#judge_input_legal1"
  post "user/:id/admin_modify_account_key"=>"user#admin_modify_key"


  delete 'user/delete_account/:id'=> 'user#delete_account', :as =>'user'



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
