function ActivitySignUpController($scope, $navigate) {

    SignUp.activity_sign_up_inti()

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
            $scope.sign_up_names = SignUp.get_showed_info()
            $scope.number = SignUp.numbers(SignUp.get_activity_id())
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



