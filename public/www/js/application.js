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
        if(id==localStorage.yellow_bid||id==localStorage.yellow_activity){
            return "background : #B87333"
        }
    };
})
function change_yellow(){
    if(localStorage.bid_sign_up_name!=''){
        return localStorage.yellow_id
    }
}

var native_access;
$(document).ready(function () {
    native_access = new NativeAccess();
    localStorage.getItem("activities")==null? localStorage.setItem("activities",'[]'):{}
    localStorage.getItem("sign_ups")==null? localStorage.setItem("sign_ups",'[]'):{}
    localStorage.getItem("bids")==null? localStorage.setItem("bids",'[]'):{}
    localStorage.getItem("activity_id_generator")==null? localStorage.setItem("activity_id_generator",0):{}
    localStorage.getItem("current_bid")==null? localStorage.setItem("current_bid",0):{}
    localStorage.getItem("activity_sign_up_id")==null? localStorage.setItem("activity_sign_up_id",''):{}
    localStorage.getItem("bid_sign_up_name")==null? localStorage.setItem("bid_sign_up_name",''):{}
    localStorage.getItem("yellow_id")==null? localStorage.setItem("yellow_id",''):{}
    localStorage.getItem("current_activity_id")==null? localStorage.setItem("current_activity_id",''):{}
    localStorage.getItem("winners")==null? localStorage.setItem("winners",'[]'):{}
});

