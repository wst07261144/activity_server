ActivityServer::Application.routes.draw do

  root 'sessions#judge_login_or_show'

  match '/register' ,to:'user#register',via:'get'
  match '/sessions/login' ,to:'sessions#login',via:'get'
  match '/sessions/show' ,to:'sessions#judge_show',via:'get'
  match '/sessions/logout',to:'sessions#logout',via:'get'
  match "/add_account",to:"user#add_account" , via:'get'
  match '/manage_index',to:'user#manage_index',via:'get'
  match '/manage_index_or_login',to:'user#manage_index_or_login',via:'get'
  match '/reset_key1_check_account' ,to:'user#reset_key1_check_account',via:'get'
  match '/reset_key2_check_question',to:'user#reset_key2_check_question',via:"get"
  match '/reset_key3_to_reset_key',to:'user#reset_key3_to_reset_key',via:"get"
  match '/user/:id/admin_modify_account_key',to:"user#admin_modify_account_key",via:'get',:as=>"admin"

  match '/',to:'sessions#create', via:'post'
  match '/sessions/login',to:'sessions#create',via:'post'
  match '/sessions/show',to:'sessions#create',via:'post'
  match '/register' ,to:'user#judge_input_legal',via:'post'
  match '/reset_key1_check_account' ,to:'user#handle_reset_key1',via:'post'
  match '/reset_key2_check_question' ,to:'user#handle_reset_key2',via:'post'
  match "/reset_key3_to_reset_key",to:'user#handle_reset_key3' ,   via:'post'
  match "/add_account",to:"user#judge_input_legal1" ,           via:'post'
  match "/user/:id/admin_modify_account_key",to:"user#admin_modify_key",via:'post'
  match '/user/delete_account/:id',to: 'user#delete_account', via:'delete',:as =>'user'
end
