<?php

class Db {

    public $link;
    public $sql;
    public $query;
    public $last_id;
    public $log;

    public function __construct() {
        $this->link = mysql_connect('localhost', 'root', '') or die('Could not connect to server.');
        mysql_select_db('kulinar', $this->link) or die('Could not select database.');
    }

    public function __destruct() {
        //   mysql_close($this->link);
    }

    public function query() {
        $this->query = mysql_query($this->sql, $this->link);
    }

    public function LoadObjectList() {

        while ($row = mysql_fetch_array($this->query, MYSQL_ASSOC)) {
            $result[] = (object) $row;
        }
        return $result;
    }

    public function LoadObject() {
        $obj = mysql_fetch_object($this->query);
        mysql_free_result($this->query);
        return $obj;
    }

    public function LoadResult() {
        $row = mysql_fetch_assoc($this->query);
        mysql_free_result($this->query);
        return $row;
    }

    function mysql_insert($table, $inserts) {
        $values = array_map('mysql_real_escape_string', array_values($inserts));
        $keys = array_keys($inserts);

        $this->query = 'INSERT INTO `' . $table . '` (`' . implode('`,`', $keys) . '`) VALUES (\'' . implode('\',\'', $values) . '\')';
        $query = mysql_query($this->query);
        if (!$query) {
            $this->log = mysql_error();
        }

        $this->last_id = mysql_insert_id();
        return $query;
    }

}

?>