<?php
header('Content-Type: application/json');
if (!empty($_FILES)) {

    $tempPath = $_FILES['file']['tmp_name'];
    $uploadPath = '../uploads' . DIRECTORY_SEPARATOR . $_FILES['file']['name'];

    move_uploaded_file($tempPath, $uploadPath);

    $answer = array('answer' => 'File transfer completed');
    $json = json_encode($answer);

    echo $json;
} else {
    $answer = array('answer' => 'No files');

    echo json_encode($answer);
}
?>