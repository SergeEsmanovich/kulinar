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
kulinarControllers.controller('TestCtrl', ['$scope', '$http', '$rootScope',
    function($scope, $http, $rootScope) {
        $scope.menu = 'test';
        $rootScope.windowWidth;
        $scope.colums = [1, 2, 3, 4, 5, 6];
        $scope.items = [
        {id:1, text:'test1',ing:[1,2,3,4,5,6,7]},
        {id:2, text:'test2',ing:[1,2,3,4,5,6,7]},
        {id:3, text:'test3',ing:[1,2,3,4]},
        {id:4, text:'test4',ing:[1,2,3,4]},
        {id:5, text:'test5',ing:[1,2,3,4,5,6,7]},
        {id:6, text:'test6',ing:[1,2,3,4,5,6,7]},
        {id:7, text:'test7',ing:[1,2,3,4,5,6,7]},
        {id:8, text:'test8',ing:[1,2,3]},
        {id:9, text:'test9',ing:[1,2,3,4,5,6,7]},
        {id:10, text:'test10',ing:[1,2]},
        {id:11, text:'test11',ing:[1,2,3,4,5,6,7]},
        {id:12, text:'test12',ing:[1,2,6,7]},
        {id:13, text:'test13',ing:[1,2,3,4,5,6,7]}
        ];

        var format = function(items, count_colums){
           var colums = [];
           var index = [];
           for (var i = 0; i < count_colums; i++) {
                index[i] = 0;
                colums[i] = new Array();
           }
            angular.forEach(items, function(val,key){
                //Есть элемент нужно определить куда го положить
                //Найдем минимальный элемент и все время будем складировать в минимум
                var min = index[0];
                var ind = 0;
                for (var i = 1; i < index.length; i++) {
                  if(index[i] < min){
                     min =  index[i];
                     ind = i;
                  }
                };
                //Нашли минимальный индекс
                index[ind] = min + val.ing.length;
                colums[ind].push(val);
            });
            $scope.colums = colums;
        }
        
       

        $scope.$watch('windowWidth', function(newVal, oldVal) {
            switch (true) {
                case newVal < 600:
                    format($scope.items,1);
                    break;
                case newVal < 700:
                    format($scope.items,2);
                    break;
                case newVal < 900:
                    format($scope.items,3);
                    break;
                case newVal < 1200:
                    format($scope.items,4);
                    break;
                case newVal < 1400:
                    format($scope.items,4);
                    break;
                default:
                    format($scope.items,6);
                    break;
            }
        });
        $scope.get_class = function() {
            switch ($scope.colums.length) {
                case 1:
                    return 'col-md-12 col-sm-12 col-xs-12';
                    break;
                case 2:
                    return 'col-md-6 col-sm-6 col-xs-6';
                    break;
                case 3:
                    return 'col-md-4 col-sm-4 col-xs-4';
                    break;
                case 4:
                    return 'col-md-3 col-sm-3 col-xs-3';
                    break;
                
                default:
                    return 'col-md-2 col-sm-2 col-xs-2';
                    break;
            }
        }
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
                console.log(data);
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