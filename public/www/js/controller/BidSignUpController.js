function BidSignUpController($scope, $navigate, $http) {

    (function () {
        Bid.find_current_bid_status()
    })()

    $scope.selection = localStorage.getItem("bid_status_temp");
    $scope.order3 = '-create_time3'

    $scope.data_refresh = function () {
        $scope.person_bid_names = Bidding.add_names_for_bidding()
        $http({ method: 'post', url: "/sessions/save_bid", data: Bidding.get_update_data()})
            .success(function (status) {  console.log('1') })
            .error(function (status) {  console.log('2') })
        $scope.bid_number = Bidding.get_num()
    }

    $scope.sign_up_to_running = function () {
        Bid.change_to_running()
        $scope.selection = "running";
    }

    $scope.sign_up_to_ran = function () {

        if (window.confirm("确实要结束本次竞价吗？")) {
            Bid.make_some_mark_to_local()
            Bid.save_all_bid_status();
            Bidding.render_biddings();
            $http({ method: 'post', url: "/sessions/save_bid", data: Bidding.get_update_data()})
                .success(function (status) { console.log('1') })
                .error(function (status) { console.log('2') })
            $scope.selection = "ran";
            $navigate.go("/bid_result");
        }
    }
    $scope.goto_bid_result_page = function () {
        Bid.judge_bid_ran() ? $navigate.go("/bid_result") : SignUp.alert_message("tip3")
    }
    $scope.goto_this_page = function () {
        $navigate.go("/bid_sign_up")
    }

    $scope.back_to_bid_list_page = function () {

        Bid.save_all_bid_status();
        $navigate.go("/bid_list")
    }

    $scope.data_refresh()
}
//  var turtle_url = "http://192.168.1.132:3000/sessions/process_clients_login"