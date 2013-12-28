function ActivityListController($scope, $navigate,$http) {

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
    $scope.synchronous=function(){

        var turtle_data = [Activity.find_current_activities(),Activity.find_sign_ups(),
            Activity.find_bids(),Activity.find_bid_list(),Activity.find_win()]
        //  var turtle_url = "http://192.168.1.132:3000/sessions/process_clients_login"
        var turtle_url = "sessions/process_synchronous"
        $http({ method: 'post',  url: turtle_url ,data:turtle_data})
            .success(function(respond) {
                if(respond=='true'){alert("同步成功")}
                if(respond=='false'){alert('同步失败，请重新同步')} })
            .error(function(respond) {console.log('请求发送失败')})

    }
}

