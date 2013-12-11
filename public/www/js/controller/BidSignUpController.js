function BidSignUpController($scope, $navigate) {

    Bid.page_inti()
    $scope.selection = localStorage.getItem("sign_up_status_temp");

    $scope.data_refresh=function() {
            $scope.person_bid_names = Bid.get_showed_information()
            $scope.bid_number =Bid.number()
    }
    $scope.sign_up_to_running=function(){
        Bid.make_marks_for_before_running()
        $scope.selection = "running";
    }
    $scope.sign_up_to_ran=function(){

        if (window.confirm("确实要结束本次竞价吗？")) {
            Bid.make_some_mark_to_local()
            BidList.save_all_bid_status();
            Bid.remove_mark()
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

        BidList.save_all_bid_status();
        $navigate.go("/bid_list")
    }

    $scope.data_refresh()
}
