<?php

include_once 'db.php';
include_once 'auth.php';
include_once 'recipes.php';
include_once 'upload.php';




if (!empty($_GET['action'])) {
    $action = $_GET['action'];
}
if (!empty($_POST['action'])) {
    $action = $_POST['action'];
}
//Проверку по токену сделать нужно
switch ($action) {
    case 'ingredients' :
        header('Content-Type: application/json');
        $recipes = new Recipes();
        $recId = $_GET['recId'];
        if ($recId) {
            echo $recipes->getIngredients($recId);
        } else {
            echo $recipes->getAllIngredients();
        }
        break;
    case 'add_recipes':
        header('Content-Type: application/json');
        $recipes = new Recipes();
        echo json_encode($recipes->add($_POST));
        break;
    case 'upload':
        //   header('Content-Type: application/json');
        //Проверить пользователя и записать его фотки 
        $upload = new Upload(); //коммент
        call_user_func(array($upload, 'out'));

        break;

    case 'auth':
        header('Content-Type: application/json');
        $ident = new auth();
        if (isset($_GET['auth'])) {
            $auth = $_GET['auth'];
            switch ($auth) {
                case 'user':
                    $ident->get_user();
                    break;
                case 'logout':
                    $ident->logount();
                    break;
                default:
                    $ident->login();
                    break;
            }
        } else {
            $ident->login();
        }
        break;

    default :
        // header('Content-Type: application/json');
        $recipes = new Recipes();
        $shag = $_GET['shag'];
        echo $recipes->getRecipes($shag);
        break;
}
?>
