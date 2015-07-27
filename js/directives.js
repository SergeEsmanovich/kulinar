'use strict';

/* Directives */
var INTEGER_REGEXP = /^\-?\d+$/;
kulinarControllers.directive('integer', function () {
    return {
        require: 'ngModel',
        link: function ($scope, $elm, $attrs, $ctrl) {
            $ctrl.$validators.integer = function (modelValue, viewValue) {

                console.log($attrs.integer);

                if (!isNaN(viewValue)) {
                    // it is valid
                    $scope.newrecept.multipleIngredients.items[$attrs.integer].invalid = 0;
                    return true;
                }

                if ($ctrl.$isEmpty(modelValue)) {
                    // consider empty models to be valid
                    //alert('пусто');
                    return true;
                }



                $scope.newrecept.multipleIngredients.items[$attrs.integer].invalid = 1;


                // it is invalid
                return false;
            };
        }
    };
});


kulinarControllers.directive('menu', function () {
    return {
        restrict: 'E',
        transclude: true,
        scope: {},
        controller: function ($scope, $http, $location) {

            $scope.menu = [{class: 'active', text: 'Главная', link: '/home', show: 0}, {class: '', text: 'Добавить рецепт', link: '/recipes', show: 1}];
            $scope.getClass = function (path) {
                if ($location.path().substr(0, path.length) == path) {
                    return "active"
                } else {
                    return ""
                }
            }
            $scope.getShow = function (index) {
                if ($scope.menu[index].show) {
                    if ($scope.login) {
                        return 1;
                    } else {
                        return 0;
                    }
                } else {
                    return 1
                }
            }




            $http.get('php/auth.php?action=user').
                    success(function (data, status, headers, config) {
                        $scope.user = data;
                        if ($scope.user.user_id > 0) {
                            $scope.login = 1;
                        } else {
                            $scope.login = 0;
                        }
                        console.log(data);
                    }).
                    error(function (data, status, headers, config) {

                    });

            $scope.logout = function () {
                $http.get('php/auth.php?action=logout').
                        success(function (data, status, headers, config) {
                            $scope.user = null;
                            $scope.login = 0;
                        }).
                        error(function (data, status, headers, config) {

                        });
            }
        },
        templateUrl: 'menu/menu.html'
    };
});


kulinarControllers.directive('activeLink', ['$location', function (location) {
        return {
            restrict: 'A',
            link: function (scope, element, attrs, controller) {
                var clazz = attrs.activeLink;
                var path = attrs.href;
                path = path.substring(1); //hack because path does not return including hashbang
                scope.location = location;
                scope.$watch('location.path()', function (newPath) {
                    if (path === newPath) {
                        element.addClass(clazz);
                    } else {
                        element.removeClass(clazz);
                    }
                });
            }
        };
    }]);



kulinarControllers.directive('ngThumb', ['$window', function ($window) {
        var helper = {
            support: !!($window.FileReader && $window.CanvasRenderingContext2D),
            isFile: function (item) {
                return angular.isObject(item) && item instanceof $window.File;
            },
            isImage: function (file) {
                var type = '|' + file.type.slice(file.type.lastIndexOf('/') + 1) + '|';
                return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
            }
        };

        return {
            restrict: 'A',
            template: '<canvas/>',
            link: function (scope, element, attributes) {
                if (!helper.support)
                    return;

                var params = scope.$eval(attributes.ngThumb);

                if (!helper.isFile(params.file))
                    return;
                if (!helper.isImage(params.file))
                    return;

                var canvas = element.find('canvas');
                var reader = new FileReader();

                reader.onload = onLoadFile;
                reader.readAsDataURL(params.file);

                function onLoadFile(event) {
                    var img = new Image();
                    img.onload = onLoadImage;
                    img.src = event.target.result;
                }

                function onLoadImage() {
                    var width = params.width || this.width / this.height * params.height;
                    var height = params.height || this.height / this.width * params.width;
                    canvas.attr({width: width, height: height});
                    canvas[0].getContext('2d').drawImage(this, 0, 0, width, height);
                }
            }
        };
    }]);