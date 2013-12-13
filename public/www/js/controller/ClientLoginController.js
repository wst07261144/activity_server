function ClientLoginController($scope,$navigate,$http){

      $scope.login=function(){
          var turtle_data = {"account":$scope.account,"key":$scope.key}
//          var turtle_url = "http://192.168.1.132:3000/sessions/process_clients_login"
          var turtle_url = "sessions/process_clients_login"
          $http({ method: 'post',  url: turtle_url ,data:turtle_data})
              .success(function(respond) {
                  if(respond=='帐号名或密码错误'){
                      alert(respond)
                  }
                  if(respond=='登录成功'){
                      Activity.save_current_user($scope.account)
                      $navigate.go('/activity_list')
                  }
              })
              .error(function(respond) {
              })
      }

}
