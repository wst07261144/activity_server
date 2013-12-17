myModule.config(function ($routeProvider) {
    $routeProvider.when("/", {
            templateUrl: "pages/client_login.html",
            controller: ClientLoginController
        }).when("/activity_list", {
            templateUrl: "pages/activity_list.html",
            controller: ActivityListController
        }).when("/create", {
            templateUrl: "pages/create_activity.html",
            controller: CreateActivityController
        }).when("/sign", {
            templateUrl: "pages/activity_sign_up.html",
            controller: ActivitySignUpController
        }).when("/bid_list", {
            templateUrl: "pages/bid_list.html",
            controller: BidListController
        }).when("/bid_sign_up", {
            templateUrl: "pages/bid_sign_up.html",
            controller: BidSignUpController
        }).when("/bid_result", {
            templateUrl: "pages/bid_result.html",
            controller: BidResultController
        }).when("/price_count", {
            templateUrl: "pages/price_count.html",
            controller: PriceCountController
        }).otherwise({
            redirectTo: "/"
        });
});


/** Here is example
myModule.config(function($routeProvider) {
    $routeProvider.when("/", {
        templateUrl: "pages/activity_list_page.html",
        controller: ActivityListController
    }).when("/activity/create", {
            templateUrl: "pages/activity_create_page.html",
            controller: ActivityCreateController
        }).when("/sign_ups/list/:activity_name", {
            templateUrl: "pages/apply_page.html",
            controller: SignUpListController
        }).otherwise({
            redirectTo: "/"
        });
});
**/