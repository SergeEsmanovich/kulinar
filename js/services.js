'use strict';

/* Services */

var kulinarServices = angular.module('kulinarServices', ['ngResource']);

kulinarServices.factory('Phone', ['$resource', '$http',
    function ($resource) {
        //?action=ingredients
        return $resource('phones/:phoneId.json', {}, {
            query: {method: 'GET', params: {phoneId: 'phones'}, isArray: true}
        });
    }]);



kulinarServices.factory('Recipes', ['$http',
    function ($http) {
        var service = function () {
            this.items = [];
            this.busy = false;
            this.after = '';
            this.page = 1;
        };
        service.prototype.nextPage = function () {
            if (this.busy)
                return;
            this.busy = true;

            var url = "php/index.php?shag=" + this.page;
            $http.get(url).
                    success(function (data, status, headers, config) {
                        data = typeof data !== 'undefined' ? data : [];
                        console.log(data);
                        if (data != null)
                            if (data.length > 0) {
                                this.items = this.items.concat(data);
                                this.busy = false;
                                this.page += 1;
                            }
                    }.bind(this)).
                    error(function (data, status, headers, config) {

                    });

        };

        return service;
    }]);