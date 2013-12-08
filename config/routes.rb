ActivityServer::Application.routes.draw do

  resource :users
  resource :sessions
  root to:'sessions#login'

  match '/register',to:"user#register"  ,via:get


  get "user/logout"
  get "user/login_success"
  get "user/reset_key1_check_account"
  get "user/reset_key2_check_question"
  get "user/reset_key3_to_reset_key"
  get "user/manage_index",:as => "manage_index"
  get "user/add_account"
  get "user/:id/admin_modify_account_key"=>"user#admin_modify_account_key" ,:as=>"admin"

  post "/" => 'user#handle_login'
  post "user/register"=>'user#judge_input_legal'
  post "user/reset_key1_check_account"=>'user#handle_reset_key1'
  post "user/reset_key2_check_question"=>'user#handle_reset_key2'
  post "user/reset_key3_to_reset_key"=>'user#handle_reset_key3'
  post "user/add_account"=>"user#judge_input_legal1"
  post "user/:id/admin_modify_account_key"=>"user#admin_modify_key"

  delete 'user/delete_account/:id'=> 'user#delete_account', :as =>'user'






end
