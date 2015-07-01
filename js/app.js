'use strict';

/* App Module */

var phonecatApp = angular.module('phonecatApp', [
    'ngRoute',
    'phonecatAnimations',
    'phonecatControllers',
    'phonecatFilters',
    'phonecatServices',
    'ngSanitize',
    'ui.select',
    'duScroll',
    'angular-inview',
    'textAngular'
]);

phonecatApp.config(['$routeProvider',
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
