function CreateActivityController($scope, $navigate,$http) {

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
            Activity.mark_status()
            var activity = new Activity($scope.activity_name)
            activity.create()
            var turtle_url = "/sessions/activity_save_activity"
            $http({ method: 'post',  url: turtle_url ,data:activity})
                .success(function(status){ console.log('1')})
                .error(function(status) {console.log('2')})
            $navigate.go("/sign")
        }
    }

    $scope.goto_creativity_list_page = function () {
        $navigate.go("/activity_list");
    }
}




