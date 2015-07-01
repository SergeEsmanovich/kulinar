<?php

include_once 'db.php';

class Recipes extends Db {

    public $recipes;
    public $structure;

    /**
     * Получение списков
     * @return Ингридиенты и граммы
     */
    function getAllIngredients() {
        $this->sql = "SELECT *  FROM ingredients i "
                . " WHERE i.id>0 "
                . "ORDER BY i.name ASC";
        $this->query();
        $ingredients = $this->LoadObjectList();

        $this->sql = "SELECT *  FROM units u WHERE u.id>0 ORDER BY u.name ASC";
        $this->query();
        $units = $this->LoadObjectList();

        $answer = new stdClass();
        $answer->ingredients = $ingredients;
        $answer->units = $units;
        return json_encode($answer);
    }

    function getIngredients($rec_id) {

        $this->sql = "SELECT *  FROM recipes "
                . "WHERE alias='$rec_id'";
        $this->query();
        $rec = $this->LoadObject();




        $fild = ' i.name,
  u.name mer,
  u.shortcut,
  s.count';

        $this->sql = "SELECT $fild  FROM structure s "
                . " LEFT JOIN ingredients i ON i.id = s.ingredients_id "
                . " LEFT JOIN units u  ON u.id = s.units_id"
                . " WHERE s.recipes_id = $rec->id";
        $this->query();
        $this->structure = $this->LoadObjectList();
        foreach ($this->structure as $key => $value) {
            if ($value->count == 0) {
                $value->count = '';
            }
        }
        $rec->structure = $this->structure;

        return json_encode($rec);
    }

    function getRecipes($shag) {
        $shag *= 20;
        $this->sql = "SELECT *  FROM recipes "
                . "ORDER BY id DESC LIMIT $shag,20";
          

        $this->query();
        $this->recipes = $this->LoadObjectList();
        return json_encode($this->recipes);
    }

    // Транслитерация строк.
    function rus2translit($string) {
        $converter = array(
            'а' => 'a', 'б' => 'b', 'в' => 'v',
            'г' => 'g', 'д' => 'd', 'е' => 'e',
            'ё' => 'e', 'ж' => 'zh', 'з' => 'z',
            'и' => 'i', 'й' => 'y', 'к' => 'k',
            'л' => 'l', 'м' => 'm', 'н' => 'n',
            'о' => 'o', 'п' => 'p', 'р' => 'r',
            'с' => 's', 'т' => 't', 'у' => 'u',
            'ф' => 'f', 'х' => 'h', 'ц' => 'c',
            'ч' => 'ch', 'ш' => 'sh', 'щ' => 'sch',
            'ь' => '\'', 'ы' => 'y', 'ъ' => '\'',
            'э' => 'e', 'ю' => 'yu', 'я' => 'ya',
            'А' => 'A', 'Б' => 'B', 'В' => 'V',
            'Г' => 'G', 'Д' => 'D', 'Е' => 'E',
            'Ё' => 'E', 'Ж' => 'Zh', 'З' => 'Z',
            'И' => 'I', 'Й' => 'Y', 'К' => 'K',
            'Л' => 'L', 'М' => 'M', 'Н' => 'N',
            'О' => 'O', 'П' => 'P', 'Р' => 'R',
            'С' => 'S', 'Т' => 'T', 'У' => 'U',
            'Ф' => 'F', 'Х' => 'H', 'Ц' => 'C',
            'Ч' => 'Ch', 'Ш' => 'Sh', 'Щ' => 'Sch',
            'Ь' => '\'', 'Ы' => 'Y', 'Ъ' => '\'',
            'Э' => 'E', 'Ю' => 'Yu', 'Я' => 'Ya',
        );
        return strtr($string, $converter);
    }

    function str2url($str) {
        // переводим в транслит
        $str = $this->rus2translit($str);
        // в нижний регистр
        $str = strtolower($str);
        // заменям все ненужное нам на "-"
        $str = preg_replace('~[^-a-z0-9_]+~u', '-', $str);
        // удаляем начальные и конечные '-'
        $str = trim($str, "-");
        return $str;
    }

    function add($post) {
        //Тут еще нужна проверка прав пользователя

        file_put_contents('test.txt', $_POST);
        $recept = json_decode($post['recept']);

        $insert_arr = array('name' => $recept->name, 'process' => $recept->htmlcontent, 'image' => 'images/Golubci.JPG', 'alias' => $this->str2url($recept->name));
        $result = $this->mysql_insert('recipes', $insert_arr);

        $rec_id = $this->last_id;

        foreach ($recept->multipleIngredients->items as $key => $value) {
            $insert_arr = array('recipes_id' => $rec_id, 'ingredients_id' => $value->id, 'units_id' => $value->unit->selected->id, 'count' => $value->count);
            $result = $this->mysql_insert('structure', $insert_arr);
        }
    }

}
?>

