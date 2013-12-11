function BidResultController($scope,$navigate,$timeout){

    $scope.show_modal=true
    $scope.check_is_show=false
    $timeout(function() {
        $scope.show_modal=false
        $scope.check_is_show=true;
    }, 3000)

    $scope.person_bid_informations= _.sortBy(Bid.get_showed_information(),function(num){
        return Number(num.bid);
    })
    $scope.winner=Bid.is_success_and_winner(Bid.get_showed_information());
    $scope.show_success = Bid.check_bid_success()

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

