function BidResultController($scope,$navigate,$timeout){

    $scope.show_modal=true
    $scope.check_is_show=false
    $timeout(function() {
        $scope.show_modal=false
        $scope.check_is_show=true;
    }, 3000)

    $scope.bid_infos= Bidding.add_names_for_bidding()
    $scope.winner=Bidding.render_biddings();
    $scope.success=Bidding.check_bid_success()
    $scope.failure= !$scope.success

    $scope.close_this_modal=function(){
        $scope.show_modal=false
        $scope.check_is_show=true;
    }

    $scope.back_to_bid_list_page=function(){
        $navigate.go("/bid_list");
    }

    $scope.go_to_price_count_page=function(){
        $navigate.go("/price_count");
    }
}

