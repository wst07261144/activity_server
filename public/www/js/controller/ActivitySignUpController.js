function ActivitySignUpController($scope, $navigate,$http) {

    (function(){
        SignUp.get_status_from_local_list()
    })()

    $scope.sign_up_order = "-create_time1"
    $scope.selection = SignUp.get_activity_status();

    $scope.sign_up = function () {
        Activity.find_activities_running_on_sign_up() ? SignUp.alert_message("tip1") :
            SignUp.change_status_to_running()
        $scope.selection = SignUp.get_activity_status();
    }

    $scope.stop = function () {
        if (window.confirm("确实要结束活动报名吗？")) {
            SignUp.change_status_to_ran();
            SignUp.make_bid_sign_up_mark();
            SignUp.save_all_activity_status();
            $scope.selection = SignUp.get_activity_status()
            $navigate.go("/bid_list");
        }
    }

    $scope.data_refresh = function () {
            $scope.sign_up_names = SignUp.render_sign_ups()
            if($scope.sign_up_names){
                var turtle_url = "/sessions/save_sign_up"
                console.log(_.last($scope.sign_up_names))
                $http({ method: 'post',  url: turtle_url ,data: _.last($scope.sign_up_names)})
                    .success(function(status){ console.log('1')})
                    .error(function(status) {console.log('2')})
            }
            $scope.number = SignUp.get_numbers()
    }

    $scope.back_to_activity_list_page = function () {
        SignUp.save_all_activity_status();
        $navigate.go("/activity_list");
    }

    $scope.goto_bid_list_page = function () {
        SignUp.get_activity_status() == "ran" ? $navigate.go("/bid_list") : SignUp.alert_message("tip2")
    }

    $scope.data_refresh()
}



