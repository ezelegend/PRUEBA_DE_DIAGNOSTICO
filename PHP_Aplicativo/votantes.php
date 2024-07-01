<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type"); // Añadir este encabezado

// Manejar solicitud OPTIONS para CORS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

require_once('db.php');

// Función para validar el formato y dígito verificador del RUT
function validarRut($rut) {
    // Verificar formato con expresión regular
    $regex = '/^[0-9]+\.[0-9]{3}\.[0-9]{3}-[0-9kK]{1}$/';
    if (!preg_match($regex, $rut)) {
        return false;
    }

    // Eliminar puntos y guión para validar dígito verificador
    $rut = str_replace(array('.', '-'), '', $rut);
    $numero = substr($rut, 0, -1);
    $dv = substr($rut, -1);

    // Calcular dígito verificador
    $suma = 0;
    $multiplo = 2;

    for ($i = strlen($numero) - 1; $i >= 0; $i--) {
        $suma += $numero[$i] * $multiplo;
        $multiplo = ($multiplo < 7) ? $multiplo + 1 : 2;
    }

    $dvCalculado = 11 - ($suma % 11);
    $dvCalculado = ($dvCalculado == 11) ? '0' : (($dvCalculado == 10) ? 'K' : $dvCalculado);

    // Comparar dígito verificador calculado con el ingresado
    return strtoupper($dv) == $dvCalculado;
}

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
        // Validar formato y dígito verificador del RUT
        if (!validarRut($datos['rut'])) {
            http_response_code(400); // Solicitud incorrecta
            echo json_encode(array("mensaje" => "El formato del RUT no es válido."));
            exit;
        }

        // Verificar si el RUT ya existe en la base de datos
        $rut_existente_query = "SELECT COUNT(*) AS total FROM votantes WHERE rut = ?";
        $rut_existente_stmt = $conexion->prepare($rut_existente_query);
        $rut_existente_stmt->bind_param("s", $datos['rut']);
        $rut_existente_stmt->execute();
        $rut_existente_result = $rut_existente_stmt->get_result();
        $rut_existente_row = $rut_existente_result->fetch_assoc();
        
        // Verificar si el RUT ya existe
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
        
        // Convertir valores booleanos a enteros
        $web = $datos['web'] ? 1 : 0;
        $tv = $datos['tv'] ? 1 : 0;
        $redsocial = $datos['redsocial'] ? 1 : 0;
        $amigo = $datos['amigo'] ? 1 : 0;

        // Vincular los parámetros
        $stmt->bind_param("ssssiiiiiii", 
            $datos['nombre_apellido'], 
            $datos['alias'], 
            $datos['rut'], 
            $datos['email'], 
            $datos['id_region'], 
            $datos['id_comuna'], 
            $datos['id_candidato'],
            $web,
            $tv,
            $redsocial,
            $amigo
        );

        // Ejecutar la consulta
        if ($stmt->execute()) {
            http_response_code(201); // Creado
            echo json_encode(array("mensaje" => "Datos insertados correctamente."));
        } else {
            http_response_code(500); // Error interno del servidor
            echo json_encode(array("mensaje" => "No se pudieron insertar los datos."));
        }

        // Cerrar la sentencia
        $stmt->close();
    } else {
        http_response_code(400); // Solicitud incorrecta
        echo json_encode(array("mensaje" => "Faltan campos obligatorios en la solicitud."));
    }
} else {
    http_response_code(405); // Método no permitido
    echo json_encode(array("mensaje" => "Método no permitido."));
}

// Cerrar la conexión
$conexion->close();
?>
