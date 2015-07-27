'use strict';

/* App Module */

var kulinarApp = angular.module('kulinarApp', [
//    'ngMock',
    'ngRoute',
    'phonecatAnimations',
    'kulinarControllers',
    'kulinarFilters',
    'kulinarServices',
    'ngSanitize',
    'ui.select',
    //'duScroll',
    'infinite-scroll',
    'angular-inview',
    'textAngular',
    'ngFileUpload',
    'ui.bootstrap',
    'ngAnimate'
]);

kulinarApp.config(['$routeProvider',
    function ($routeProvider) {
        $routeProvider.
                when('/home', {
                    templateUrl: 'partials/home.html',
                    controller: 'HomeCtrl'                 
                }).
                when('/recipes/', {
                    templateUrl: 'partials/recipes.html',
                    controller: 'RecipesCtrl'
                }).
                when('/home/:recId', {
                    templateUrl: 'partials/recipes-detail.html',
                    controller: 'RecipesDetailCtrl'
                }).
                otherwise({
                    redirectTo: '/home'
                });
    }]);

