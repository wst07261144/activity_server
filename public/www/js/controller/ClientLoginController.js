function ClientLoginController($scope,$navigate,$http){

      $scope.tips_to_login =false
      $scope.login=function(){
          var turtle_data = {"account":$scope.account,"key":$scope.key}
        //  var turtle_url = "http://192.168.1.132:3000/sessions/process_clients_login"
          var turtle_url = "sessions/process_client_login"
          $http({ method: 'post',  url: turtle_url ,data:turtle_data})
              .success(function(respond) {
                  if(respond=='帐号名或密码错误'){ $scope.tips_to_login =true }
                  if(respond=='登录成功'){
                      Activity.save_current_user($scope.account)
                      $navigate.go('/activity_list')}
              })
              .error(function(respond) {})
      }

}
