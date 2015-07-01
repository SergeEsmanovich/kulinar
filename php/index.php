<?php

header('Content-Type: application/json');
include_once 'recipes.php';

$recipes = new Recipes();

if (!empty($_GET['action'])) {
    $action = $_GET['action'];
}
//Проверку по токену сделать нужно
switch ($action) {
    case 'ingredients' :
        $recId = $_GET['recId'];
        if ($recId) {
            echo $recipes->getIngredients($recId);
        } else {
            echo $recipes->getAllIngredients();
        }
        break;
    case 'add_recipes':
        $recipes->add($_POST);
        break;
    default :
        $shag = $_GET['shag'];
        echo $recipes->getRecipes($shag);
        break;
}
?>
