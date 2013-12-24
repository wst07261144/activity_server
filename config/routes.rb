ActivityServer::Application.routes.draw do

  root 'sessions#judge_login_or_show'
  get 'sessions/admin_scan'
  get 'manage_index/:name',:as=>'activity' ,:controller=>'user',:action=>'admin_scan'
  match '/register' ,to:'user#register',via:'get'

  match '/sessions/login' ,to:'sessions#login',via:'get'
  match '/sessions/show' ,to:'sessions#show',via:'get'
  match '/sessions/activity_show' ,to:'sessions#activity_show',via:'get'

  match '/sessions/logout',to:'sessions#logout',via:'get'
  match "/add_account",to:"user#judge_add_account" , via:'get'
  match '/manage_index',to:'user#manage_index',via:'get'
  match '/manage_index_or_login',to:'user#manage_index_or_login',via:'get'
  match "/sessions/activity_show",to:'sessions#activity_show',via:'get'
  match '/reset_key1_check_account' ,to:'user#reset_key1_check_account',via:'get'
  match '/reset_key2_check_question',to:'user#reset_key2_check_question',via:"get"
  match '/reset_key3_to_reset_key',to:'user#reset_key3_to_reset_key',via:"get"
  match '/user/:id/admin_modify_account_key',to:"user#judge_modify_account_key",via:'get',:as=>"admin"
  match '/sessions/show/:activity_id/bid_list',to:'sessions#bid_list',via:'get',:as=>'bids'
  match '/sessions/show/:activity_id/sign_up_list',to:'sessions#sign_up_list',via:'get',:as=>'sign_up'
  match '/sessions/show/:activity_id/bid_detail/',to:'sessions#bid_detail',via:'get',:as=>'bid_detail'


  match '/',to:'sessions#create', via:'post'
  match '/sessions/process_clients_login' ,to:'sessions#process_clients_login',via:'post'
  match '/sessions/process_synchronous',to:'sessions#process_synchronous',via:'post'
  match "/sessions/activity_save",to:'sessions#activity_save',via:'post'
  match "/sessions/activity_save_activity",to:'sessions#activity_save_activity',via:'post'
  match "/sessions/save_sign_up",to:'sessions#save_sign_up',via:'post'

  match "/www/sessions/process_client_login",to: 'sessions#process_clients_login',via:'post'
  match '/www/sessions/process_synchronous',to:'sessions#process_synchronous',via:'post'
  match "/www/sessions/activity_show",to:'sessions#activity_show',via:'post'
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
