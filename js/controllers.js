'use strict';
/*DB*/
//var db = openDatabase('documents', '1.0', 'Offline document storage', 5 * 1024 * 1024, function (db) {
//    db.changeVersion('', '1.0', function (t) {
//        t.executeSql('CREATE TABLE docids (id, name)');
//    }, error);
//});
//
//
//db.transaction(function (t) {
//    t.executeSql("INSERT INTO docids (id,name) values(?, ?)", [2, "mytest"], null, null);
//    t.executeSql("SELECT * FROM docids", [], function (t, result) {
//        console.log(result);
//        for (var i = 0; i < result.rows.length; i++) {
//            console.log(result.rows.item(i));
//        }
//    }, null);
//
//});
/* Controllers */
var kulinarControllers = angular.module('kulinarControllers', [], function($httpProvider) {
    // Используем x-www-form-urlencoded Content-Type
    $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';
    // Переопределяем дефолтный transformRequest в $http-сервисе
    $httpProvider.defaults.transformRequest = [function(data) {
        /**
         * рабочая лошадка; преобразует объект в x-www-form-urlencoded строку.
         * @param {Object} obj
         * @return {String}
         */
        var param = function(obj) {
            var query = '';
            var name, value, fullSubName, subValue, innerObj, i;
            for (name in obj) {
                value = obj[name];
                if (value instanceof Array) {
                    for (i = 0; i < value.length; ++i) {
                        subValue = value[i];
                        fullSubName = name + '[' + i + ']';
                        innerObj = {};
                        innerObj[fullSubName] = subValue;
                        query += param(innerObj) + '&';
                    }
                } else if (value instanceof Object) {
                    for (subName in value) {
                        subValue = value[subName];
                        fullSubName = name + '[' + subName + ']';
                        innerObj = {};
                        innerObj[fullSubName] = subValue;
                        query += param(innerObj) + '&';
                    }
                } else if (value !== undefined && value !== null) {
                    query += encodeURIComponent(name) + '=' + encodeURIComponent(value) + '&';
                }
            }
            return query.length ? query.substr(0, query.length - 1) : query;
        };
        return angular.isObject(data) && String(data) !== '[object File]' ? param(data) : data;
    }];
});
kulinarControllers.controller('TestCtrl', ['$scope', '$http',
    function($scope, $http) {
        $scope.menu = 'test';
    }
]);
kulinarControllers.controller('HomeCtrl', ['$scope', '$http', 'Recipes',
    function($scope, $http, Recipes) {
        $scope.Recipes = new Recipes();
        $scope.Recipes.nextPage();
    }
]);
//Добавление рецепта --------------------------------------------------------------------
kulinarControllers.controller('RecipesCtrl', ['$scope', '$http', '$timeout', 'Upload', '$rootScope',
    function($scope, $http, $timeout, Upload, $rootScope) {
        ///////////////////////////////////////////////
        $scope.progress = [];
        $scope.$watch('files', function(files) {
            $scope.progress = [];
            angular.forEach(files, function(value, key) {
                $scope.progress.push({
                    name: value.name,
                    procent: 0
                });
            });
        });
        $scope.remove_preview = function(index) {
            $scope.files.splice(index, 1);
        }
        $scope.upload = function(files) {
            if (files && files.length) {
                for (var i = 0; i < files.length; i++) {
                    var file = files[i];
                    Upload.upload({
                        url: '/php/index.php',
                        fields: {
                            'action': 'upload',
                            'user': $rootScope.auth.user
                        },
                        file: file
                    }).progress(function(evt) {
                        var procent = parseInt(100.0 * evt.loaded / evt.total);
                        angular.forEach($scope.progress, function(value, key) {
                            if (evt.config.file.name == value.name) value.procent = procent;
                        });
                    }).success(function(data, status, headers, config) {
                        console.log(data);
                        $scope.newrecept.photos = data.photos;
                        //$scope.files = [];
                    });
                }
            }
        };
        ////////////////////////////////////
        $scope.newrecept = {
            'name': '',
            'multipleIngredients': {
                'items': []
            },
            photos: []
        }
        $scope.ingredients = [{
            'id': 0,
            'name': ''
        }];
        $scope.units = [{
            'id': 0,
            'name': '',
            'shortcut': ''
        }];
        $http.get('php/index.php?action=ingredients').
        success(function(data, status, headers, config) {
            $scope.ingredients = data.ingredients;
            $scope.units = data.units;
            console.log($scope.units);
        }).
        error(function(data, status, headers, config) {});
        $scope.multipleUnits = {};
        $scope.multipleUnits.items = '';
        $scope.tagTransform = function(newTag) {
            var item = {
                name: newTag,
            };
            return item;
        };
        $scope.verification = function() {
            var recept = $scope.newrecept;
            // alert('Проверка');
            //            console.log(recept);
            $http.post('/php/index.php?action=add_recipes', {
                recept: JSON.stringify(recept)
            }).
            success(function(data, status, headers, config) {
                $scope.newrecept.answer = data;
                $scope.checked = 0;
                $timeout(function() {
                    $scope.newrecept.answer = null;
                }, 2000);
            }).
            error(function(data, status, headers, config) {});
        }
    }
]);
kulinarControllers.controller('PhoneDetailCtrl', ['$scope', '$routeParams', 'Phone',
    function($scope, $routeParams, Phone) {
        $scope.phone = Phone.get({
            phoneId: $routeParams.phoneId
        }, function(phone) {
            $scope.mainImageUrl = phone.images[0];
        });
        $scope.setImage = function(imageUrl) {
            $scope.mainImageUrl = imageUrl;
        }
    }
]);
//RecipesDetailCtrl
kulinarControllers.controller('RecipesDetailCtrl', ['$scope', '$http', '$routeParams',
    function($scope, $http, $routeParams) {
        $http.get('php/index.php?action=ingredients&recId=' + $routeParams.recId).
        success(function(data, status, headers, config) {
            $scope.rec = data;
        }).
        error(function(data, status, headers, config) {});
    }
]);