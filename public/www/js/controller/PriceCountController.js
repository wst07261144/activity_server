function PriceCountController($scope, $navigate) {


    $scope.price_counts = Bid.get_bid_count()

    $scope.winner = Bidding.get_winner()


    $scope.back_to_bid_list = function () {
        $navigate.go("/bid_list");
    }

    $scope.go_to_bid_result = function () {
        $navigate.go("/bid_result");
    }


}
