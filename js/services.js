'use strict';

/* Services */

var kulinarServices = angular.module('kulinarServices', ['ngResource']);



kulinarServices.factory('Recipes', ['$http',
    function ($http) {
        var service = function () {
            this.items = [];
            this.busy = false;
            this.after = '';
            this.page = 0;
            this.end = false;
        };
        service.prototype.nextPage = function () {
            if (this.busy)
                return;
            this.busy = true;

            var url = "php/index.php?shag=" + this.page;
            $http.get(url).
                    success(function (data, status, headers, config) {
                       // console.log(data);
                       // console.log(url);
                        if (data.msg != 'end') {
//                            data = typeof data !== 'undefined' ? data : [];
//                            if (data.length > 0) {
                            this.items = this.items.concat(data);
                            this.busy = false;
                            this.page += 1;
//                            }
                        } else {
                            this.busy = true;
                        }
                    }.bind(this)).
                    error(function (data, status, headers, config) {

                    });

        };

        return service;
    }]);

kulinarServices.factory('Auth', ['$http', '$location',
    function ($http, $location) {
        var service = function () {
            this.user = null;
            this.user_login = false;
        };
        service.prototype.login = function () {
            var url = "php/index.php?action=auth&auth=user";
            $http.get(url).
                    success(function (data, status, headers, config) {
                        console.log(data);
                        this.user = data;
                        this.user_login = this.user.user_id > 0 ? true : false;
                    }.bind(this)).
                    error(function (data, status, headers, config) {
                        console.log(data);
                    });
        };

        service.prototype.logout = function () {
            var url = "php/index.php?action=auth&auth=logout";
            $http.get(url).
                    success(function (data, status, headers, config) {
                        this.user = null;
                        this.user_login = false;
                        
                        $location.path('/home');
                        
                        
                    }.bind(this)).
                    error(function (data, status, headers, config) {

                    });
        }


        return service;
    }]);