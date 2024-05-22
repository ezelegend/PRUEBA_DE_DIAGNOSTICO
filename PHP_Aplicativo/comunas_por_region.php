<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Content-Type: application/json");

// Manejar solicitud OPTIONS para CORS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

require_once('db.php');

// Verificar si se ha enviado el ID de la región
if (isset($_GET['id_region'])) {
    $id_region = $_GET['id_region'];

    // Consultar las comunas asociadas a la región
    $query = "SELECT * FROM comunas WHERE id_region = ?";
    $stmt = $conexion->prepare($query);
    $stmt->bind_param("i", $id_region);
    $stmt->execute();
    $result = $stmt->get_result();

    // Crear un array para almacenar las comunas
    $comunas = array();
    while ($row = $result->fetch_assoc()) {
        $comunas[] = $row;
    }

    // Devolver las comunas como respuesta
    echo json_encode($comunas);
} else {
    http_response_code(400); // Solicitud incorrecta
    echo json_encode(array("mensaje" => "Falta el ID de la región en la solicitud."));
}
?>
