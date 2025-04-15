<?php
header("Content-Type: application/json");
include("../config/db.php");

$data = json_decode(file_get_contents("php://input"));
$id = $data->id;
$nome = $data->nome;
$email = $data->email;

$sql = "UPDATE usuarios SET nome = ?, email = ? WHERE id = ?";
$stmt = $pdo->prepare($sql);

if ($stmt->execute([$nome, $email, $id])) {
    echo json_encode(["status" => "success", "message" => "Usuário atualizado com sucesso"]);
} else {
    echo json_encode(["status" => "error", "message" => "Erro ao atualizar usuário"]);
}
