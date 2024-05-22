<?php
$server = "127.0.0.1";
$user = "root";
$pass = "root123";
$database = "bdvotacion";
$port = "3306";

$conexion = new mysqli($server, $user, $pass, $database, $port);
if ($conexion->connect_errno) {
    die("" . $conexion->connect_error);
}

function ConectionBD($sqlstr, &$conexion = null) {
    global $conexion; // Usar la variable global $conexion dentro de la función

    if (!$conexion) {
        return array(); // Devolver un array vacío si la conexión no está establecida
    }

    $result = $conexion->query($sqlstr);

    if ($result === false) {
        return array();
    }

    return $result;
}

?>
