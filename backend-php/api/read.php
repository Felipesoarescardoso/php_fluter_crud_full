<?php
header("Content-Type: application/json");
include("../config/db.php");

$sql = "SELECT id, nome, email FROM usuarios";
$stmt = $pdo->query($sql);
$usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(["status" => "success", "usuarios" => $usuarios]);
