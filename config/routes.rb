ActivityServer::Application.routes.draw do
  root 'sessions#login'
  #sessions
  match '/manage_index'=>'admins#manage_index',via:'get'
  match '/shows/show'=> 'shows#show',via:'get'
  match '/sessions/logout'=>'sessions#logout',via:'get'
  match '/sessions/process_clients_login' ,to:'sessions#process_clients_login',via:'post'
  match '/sessions/process_synchronous',to:'sessions#process_synchronous',via:'post'
  match "/sessions/save_bid",to:'sessions#save_bid',via:'post'
  match "/sessions/save_activity",to:'sessions#save_activity',via:'post'
  match "/sessions/save_sign_up",to:'sessions#save_sign_up',via:'post'
  match "/www/sessions/process_client_login",to: 'sessions#process_clients_login',via:'post'
  match '/www/sessions/process_synchronous',to:'sessions#process_synchronous',via:'post'
  match "/www/sessions/activity_show",to:'sessions#activity_show',via:'post'
  match '/shows/show'=>'sessions#create',via:'post'
  #shows
  match '/sessions/show/:activity_id/bid_list'=>'shows#bid_list',via:'get',:as=>'bids'
  match '/sessions/show/:activity_id/sign_up_list'=>'shows#sign_up_list',via:'get',:as=>'sign_up'
  match '/sessions/show/:activity_id/bid_detail/'=>'shows#bid_detail',via:'get',:as=>'bid_detail'
  match "/sessions/activity_show"=>'sessions#activity_show',via:'get'
  match '/shows/activity_show' ,to:'shows#activity_show',via:'get'
  #admins
  get 'sessions/admin_scan'
  get 'manage_index/:name',:as=>'activity' ,:controller=>'admins',:action=>'admin_scan'
  match "/add_account"=>"admins#add_account" , via:'get'
  match "/add_account"=>"user#admin_create" ,  via:'post'
  match "/user/:id/admin_modify_account_key"=>"admins#admin_modify_key",via:'post'
  match '/admins/delete_account/:id'=> 'admins#delete_account', via:'delete',:as =>'user'
  match '/user/:id/admin_modify_account_key'=>"admins#admin_modify_account_key",via:'get',:as=>"admin"
   #user
  match '/',to:'sessions#create', via:'post'
  match '/register' =>'user#register',via:'get'
  match '/register' =>'user#create',via:'post'
  match '/sessions/login'=>'sessions#login',via:'get'
  match '/reset_key1_check_account' =>'user#reset_key1_check_account',via:'get'
  match '/reset_key2_check_question'=>'user#reset_key2_check_question',via:"get"
  match '/reset_key3_to_reset_key'=>'user#reset_key3_to_reset_key',via:"get"
  match '/reset_key1_check_account' =>'user#handle_reset_key1',via:'post'
  match '/reset_key2_check_question' =>'user#handle_reset_key2',via:'post'
  match "/reset_key3_to_reset_key"=>'user#handle_reset_key3' ,   via:'post'
end