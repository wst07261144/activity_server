var myModule = angular.module('myApp', ['mobile-navigate']);

myModule.run(function($route, $http, $templateCache) {
    angular.forEach($route.routes, function(r) {
        if (r.templateUrl) {
            $http.get(r.templateUrl, {cache: $templateCache});
        }
    });
});

myModule.controller('MainCtrl', function($scope, $navigate) {
    $scope.$navigate = $navigate;
});

myModule.directive('ngTap', function() {
    var isTouchDevice = !!("ontouchstart" in window);
    return function(scope, elm, attrs) {
        if (isTouchDevice) {
            var tapping = false;
            elm.bind('touchstart', function() { tapping = true; });
            elm.bind('touchmove', function() { tapping = false; });
            elm.bind('touchend', function() {
                tapping && scope.$apply(attrs.ngTap);
            });
        } else {
            elm.bind('click', function() {
                scope.$apply(attrs.ngTap);
            });
        }
    };
});

myModule.filter('status',function(){
    return function(status) {
        if(status=='running'){
            return "background : #B87333"
        }
    };
})
myModule.filter('id',function(){
    return function(id) {
        var length=JSON.parse(localStorage.getItem("event_name")).length
        if(id== Activity.find_id_of_running()){
             return "background : #B87333"
        }
        if(id==length-1-Number(localStorage.getItem("current_activity"))){
            return "background : #B87333"
        }
    };
})
var native_access;
$(document).ready(function () {
    native_access = new NativeAccess();
    activity_sign_up_inti();
    bid_sign_up_inti();
});
function activity_sign_up_inti(){

     localStorage.getItem("event_name")==null? localStorage.setItem("event_name",'[]'):{}
     localStorage.getItem("sign_up_id")==null?localStorage.setItem("sign_up_id",0):{}
     localStorage.getItem("counter of activity_list")==null?localStorage.setItem("counter of activity_list",-1):{}
     localStorage.getItem("activity_status_temp")==null?localStorage.setItem("activity_status_temp","before_running"):{}

}
function bid_sign_up_inti(){

    localStorage.getItem("record_bid_sign_up_status")==null?localStorage.setItem("record_bid_sign_up_status","before_running"):{}
    localStorage.getItem("sign_up_status_temp")==null?localStorage.setItem("sign_up_status_temp","before_running"):{}
    localStorage.getItem("peron_bid_index")==null?localStorage.setItem("peron_bid_index",'[]'):{}
    localStorage.getItem("current_activity")==null?localStorage.setItem("current_activity","undefined"):{}
}



