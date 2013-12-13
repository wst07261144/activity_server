function ActivityListController($scope, $navigate) {

    $scope.create_btn_can_tap = Activity.activity_is_process();

    $scope.activities = Activity.find_all_activities();

    $scope.order = "-create_time"

    $scope.go_to_create_activity_page = function () {

        if (!Activity.activity_is_process()){
            $navigate.go("/create");
        }
    }
    $scope.scan_sign_up_information = function (activity_name) {

        Activity.scan_sign_up_information_marks(activity_name);
        $navigate.go("/sign");

    }
}

