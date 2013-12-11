function BidListController($scope, $navigate, $timeout) {


    $scope.check_is_start = Bid.judge_button_can_click()
    $scope.save_bid_lists = Bid.get_showed_info()

    $scope.go_to_bid_sign_up_page = function () {
        if (!$scope.check_is_start) {
            Bid.save_bid_info_and_process();
            $navigate.go("/bid_sign_up");
        }
    }
    $scope.scan_bid_sign_up_information = function (id) {

        Bid.make_some_scan_marks(id);
        $navigate.go("/bid_sign_up");

    }
    $scope.goto_sign_up = function () {
        $navigate.go("/sign")
    }

}