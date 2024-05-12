<?php

$db_name = 'mysql:host=database;dbname=restaurant';
$user_name = 'restaurant';
$user_password = '@@restaurant@@';

$conn = new PDO($db_name, $user_name, $user_password);

?>
