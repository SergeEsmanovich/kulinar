<?php

class auth extends Db {

    public $login_user;

    private function find_user($user) {
        $this->sql = "SELECT * FROM users WHERE uid = '$user->uid' AND network = '$user->network' ";
        $this->query();
        return $this->LoadObject($user);
    }

    public function login() {
        if (isset($_POST['token'])) {
            session_start();
            $token = $_POST['token'];
            $s = file_get_contents('http://ulogin.ru/token.php?token=' . $_POST['token'] . '&host=' . $_SERVER['HTTP_HOST']);
            file_put_contents('auth.txt', $s);
            $user = json_decode($s);
            if (($_SESSION['network'] != $user->network) && ($_SESSION['uid'] != $user->uid)) {

                if (!empty($user)) {
                    $this->login_user = $this->find_user($user);
                    if (empty($this->login_user)) {
                        $insert_arr = array('uid' => $user->uid, 'network' => $user->network, 'username' => $user->first_name);
                        $result = $this->mysql_insert('users', $insert_arr);

                        $user_id = $this->last_id;


                        $insert_arr = array('user_id' => $user_id, 'token' => $token, 'ip' => $_SERVER['REMOTE_ADDR']);
                        $result = $this->mysql_insert('user_tokens', $insert_arr);

                        $_SESSION['user_id'] = $user_id;
                        $_SESSION['ip'] = $_SERVER['REMOTE_ADDR'];
                        $_SESSION['token'] = $_POST['token'];
                        $_SESSION['first_name'] = $user->first_name;
                        $_SESSION['network'] = $user->network;
                        $_SESSION['uid'] = $user->uid;
                    } else {
                        $_SESSION['user_id'] = $this->login_user->id;
                        $_SESSION['ip'] = $_SERVER['REMOTE_ADDR'];
                        $_SESSION['token'] = $_POST['token'];
                        $_SESSION['first_name'] = $this->login_user->username;
                        $_SESSION['network'] = $this->login_user->network;
                        $_SESSION['uid'] = $this->login_user->uid;
                    }
                }
            }

            header("Location: http://" . $_SERVER['HTTP_HOST']);
            exit;
        } else {
            session_start();
            session_destroy();
            header("Location: http://" . $_SERVER['HTTP_HOST']);
            exit;
        }
    }

    public function get_user() {
        session_start();
        echo json_encode($_SESSION);
    }

    public function get_user_in() {
        session_start();
        return json_encode($_SESSION);
    }

    public function logount() {
        session_start();
        session_destroy();
    }

}

?>