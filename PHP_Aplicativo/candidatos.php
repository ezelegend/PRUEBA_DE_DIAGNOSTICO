<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Manejar solicitud OPTIONS para CORS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

require_once('db.php');

$query = "SELECT * FROM candidatos";
$result = ConectionBD($query);

$candidatos = [];
while ($row = $result->fetch_assoc()) {
    $candidatos[] = $row;
}

header('Content-Type: application/json');
echo json_encode($candidatos);