<?php

class Upload extends auth {
    /**
     * <b>Загрузка файлов на сервер</b>
     * Конструктор проверяет поступили ли на сервер файлы и загоняет их куда нужно
     * 
     */

    /**
     *
     * @var array Возвращет результат выполнения загрузки файлов
     */
    public $answer = array('answer' => '0');
    public $user_id;

    public function __construct() {
        parent::__construct();
        $msg = array();

        if (isset($_POST['user']))
            $user_p = json_decode($_POST['user']);
        $user = json_decode($this->get_user_in());
        $collation = $user_p->token == $user->token ? true : false;

        if ($collation) {
            $this->user_id = $user->user_id;
            if (!empty($_FILES)) {
                //Нужно еще сделать проверку на тип файлов
                $tempPath = $_FILES['file']['tmp_name'];
                $uploadPath = '../uploads' . DIRECTORY_SEPARATOR . $_FILES['file']['name'];
                move_uploaded_file($tempPath, $uploadPath);

                //Запись изображения в базу
                $insert_arr = array('user_id' => $this->user_id, 'path' => "$uploadPath");
                $result = $this->mysql_insert('photos', $insert_arr);

                $msg['answer'] = 'Файлы успешно загружены';

                $msg['confirm'] = $collation;
                $msg['record_in_db'] = $result;
                $msg['status'] = 1;
                $msg['msg'] = 'Изображения успешно загружены';

                $msg['photo']['id'] = $this->last_id;
                $msg['photo']['path'] = $uploadPath;

                if (!$result) {
                    $msg['query'] = $this->query;
                    $msg['log'] = $this->log;
                }


                $this->answer = $msg;
            } else {
                $this->answer = array('answer' => 'No files');
            }
        } else {
            $msg['status'] = 0;
            $msg['msg'] = 'Пройдите авторизацию';
            $msg['user_p'] =$user_p->token;
            $msg['user'] =  $user->token;
            $this->answer = $msg;
        }
    }

    public function out() {
       $this->sql = "SELECT *  FROM photos "
               . "WHERE user_id='$this->user_id'";
       $this->query();
       $photos = $this->LoadObjectList();
       $this->answer['photos'] = $photos;
        echo json_encode($this->answer);
    }

}

?>