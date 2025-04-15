<?php
header("Content-Type: application/json");
include("../config/db.php");

$data = json_decode(file_get_contents("php://input"));
$id = $data->id;

$sql = "DELETE FROM usuarios WHERE id = ?";
$stmt = $pdo->prepare($sql);

if ($stmt->execute([$id])) {
    echo json_encode(["status" => "success", "message" => "Usuário deletado com sucesso"]);
} else {
    echo json_encode(["status" => "error", "message" => "Erro ao deletar usuário"]);
}
