function CreateActivityController($scope, $navigate) {

    (function(){
        $scope.disabled = true;
        $scope.prompt_of_null = false;
        $scope.prompt_of_repeat = false;
    })()

    $scope.change = function () {
        $scope.disabled= $scope.activity_name === "";
        $scope.prompt_of_null= $scope.activity_name === "";
        $scope.prompt_of_repeat= Activity.check_input_name_repeat($scope.activity_name)!=undefined
        $scope.can_create= !$scope.prompt_of_null&&!$scope.prompt_of_repeat
    }

    $scope.create_activity = function () {
        if ($scope.can_create){
            Activity.make_some_create_marks();
            Activity.save_person_bid_index();
            new Activity($scope.activity_name).save_activity_list_name();
            var activity_id=Activity.find_counter_of_activity_list();
            SignUp.inti(activity_id)
            Bid.init_bid_list(activity_id)
            go_to_sign_page();
        }
    }
    function go_to_sign_page() {
        $navigate.go("/sign");
    }
    $scope.goto_creativity_list_page = function () {
        $navigate.go("/activity_list");
    }
}




