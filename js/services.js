'use strict';

/* Services */

var phonecatServices = angular.module('phonecatServices', ['ngResource']);

phonecatServices.factory('Phone', ['$resource',
    function ($resource) {
        //?action=ingredients
        return $resource('phones/:phoneId.json', {}, {
            query: {method: 'GET', params: {phoneId: 'phones'}, isArray: true}
        });
    }]);


var recipesServices = angular.module('recipesServices', ['$http']);

phonecatServices.factory('Recipes', ['$http',
    function ($http) {
        var test = {};
        test.get = function (id) {
            
            return {'test':'test'}
        };

        return test;
    }]);