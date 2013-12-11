function ClientLoginController($scope,$navigate,$http){

    $scope.login=function(){
        var turtle_data = {"account":$scope.account,"key":$scope.key}
        var turtle_url = "sessions/process_clients_login"
        $http({ method: 'post',  url: turtle_url ,data:turtle_data})
            .success(function(respond) {
                respond=='帐号名或密码错误'?alert(respond):$navigate.go('/activity_list')
            })
            .error(function(respond) {
            })
    }
}
