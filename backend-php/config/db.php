<?php
$host = "localhost";
$db_name = "flutter_api";
$username = "root";
$password = "";

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db_name;charset=utf8", $username, $password);
} catch (PDOException $e) {
    die(json_encode(["error" => "Erro na conexão: " . $e->getMessage()]));
}
