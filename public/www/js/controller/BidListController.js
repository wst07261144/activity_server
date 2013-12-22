function BidListController($scope, $navigate) {

    $scope.check_is_start = Bid.judge_button_can_click()
    $scope.bids = Bid.render_bids()
    $scope.order2 = '-create_time2'
    $scope.go_to_bid_sign_up_page = function () {
        if (!$scope.check_is_start) {
            Bid.create_new_bid();
            $navigate.go("/bid_sign_up");
        }
    }
    $scope.scan_bid_sign_up_information = function (bid_name) {

        Bid.save_current_bid(bid_name);
        $navigate.go("/bid_sign_up");

    }
    $scope.goto_sign_up = function () {
        $navigate.go("/sign")
    }

}