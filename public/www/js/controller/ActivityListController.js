function ActivityListController($scope, $navigate) {

    $scope.create_btn_can_tap = Activity.find_activities_running_on_sign_up();

    $scope.activities = Activity.find_all_activities();


    $scope.go_to_create_activity_page = function () {

        if (!Activity.find_activities_running_on_sign_up()){
            $navigate.go("/create");
        }
    }
    $scope.scan_sign_up_information = function (id) {

        Activity.scan_sign_up_information_marks(id);
        $navigate.go("/sign");

    }
}

