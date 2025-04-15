<?php
header("Content-Type: application/json");
include("../config/db.php");

$data = json_decode(file_get_contents("php://input"));
$nome = $data->nome;
$email = $data->email;
$senha = md5($data->senha);

$sql = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";
$stmt = $pdo->prepare($sql);

if ($stmt->execute([$nome, $email, $senha])) {
    echo json_encode(["status" => "success", "message" => "Usuário criado com sucesso"]);
} else {
    echo json_encode(["status" => "error", "message" => "Erro ao criar usuário"]);
}
