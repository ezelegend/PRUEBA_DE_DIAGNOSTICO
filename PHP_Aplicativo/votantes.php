<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json");

// Manejar solicitud OPTIONS para CORS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

require_once('db.php');

// Verificar si la solicitud es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener los datos enviados en la solicitud POST
    $datos = json_decode(file_get_contents("php://input"), true);

    // Verificar si se han enviado todos los campos necesarios
    if (
        isset($datos['nombre_apellido']) && 
        isset($datos['alias']) && 
        isset($datos['rut']) && 
        isset($datos['email']) && 
        isset($datos['id_region']) && 
        isset($datos['id_comuna']) && 
        isset($datos['id_candidato']) &&
        !empty($datos['nombre_apellido']) && 
        !empty($datos['alias']) && 
        !empty($datos['rut']) && 
        !empty($datos['email']) && 
        !empty($datos['id_region']) && 
        !empty($datos['id_comuna']) && 
        !empty($datos['id_candidato'])
    ) {
        // Verificar si el RUT ya existe en la base de datos
        $rut_existente_query = "SELECT COUNT(*) AS total FROM votantes WHERE rut = ?";
        $rut_existente_stmt = $conexion->prepare($rut_existente_query);
        $rut_existente_stmt->bind_param("s", $datos['rut']);
        $rut_existente_stmt->execute();
        $rut_existente_result = $rut_existente_stmt->get_result();
        $rut_existente_row = $rut_existente_result->fetch_assoc();
        if ($rut_existente_row['total'] > 0) {
            http_response_code(400); // Solicitud incorrecta
            echo json_encode(array("mensaje" => "El RUT ya existe en la base de datos."));
            exit;
        }

        // Preparar la consulta SQL para insertar los datos
        $query = "INSERT INTO votantes (nombre_apellido, alias, rut, email, id_region, id_comuna, id_candidato, web, tv, redsocial, amigo) 
                  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        // Preparar la sentencia
        $stmt = $conexion->prepare($query);
        
        // Vincular los parámetros
        $stmt->bind_param("ssssiiiiiii", 
            $datos['nombre_apellido'], 
            $datos['alias'], 
            $datos['rut'], 
            $datos['email'], 
            $datos['id_region'], 
            $datos['id_comuna'], 
            $datos['id_candidato'],
            $datos['web'],
            $datos['tv'],
            $datos['redsocial'],
            $datos['amigo']
        );

        // Ejecutar la consulta
        if ($stmt->execute()) {
            http_response_code(201); // Creado
            echo json_encode(array("mensaje" => "Datos insertados correctamente."));
        } else {
            http_response_code(500); // Error interno del servidor
            echo json_encode(array("mensaje" => "No se pudieron insertar los datos."));
        }
    } else {
        http_response_code(400); // Solicitud incorrecta
        echo json_encode(array("mensaje" => "Faltan campos obligatorios en la solicitud."));
    }
} else {
    http_response_code(405); // Método no permitido
    echo json_encode(array("mensaje" => "Método no permitido."));
}
?>
