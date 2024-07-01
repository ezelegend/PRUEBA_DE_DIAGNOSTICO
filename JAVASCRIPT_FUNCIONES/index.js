const apiUrlRegiones = "http://localhost:3000/PHP_Aplicativo/regiones.php";
const selectRegiones = document.getElementById("selectRegiones");
fetch(apiUrlRegiones)
  .then((response) => {
    if (!response.ok) {
      throw new Error("Error en la solicitud");
    }
    return response.json();
  })
  .then((data) => {
    console.log("Datos de la API:", data);
    data.forEach((region) => {
      const option = document.createElement("option");
      option.value = region.id_region;
      option.textContent = region.nombre;
      selectRegiones.appendChild(option);
    });
  })
  .catch((error) => {
    console.error("Error al obtener los datos:", error);
  });

const apiUrlComunas = "http://localhost:3000/PHP_Aplicativo/comunas.php";
const selectComunas = document.getElementById("selectComunas");
fetch(apiUrlComunas)
  .then((response) => {
    if (!response.ok) {
      throw new Error("Error en la solicitud");
    }
    return response.json();
  })
  .then((data) => {
    console.log("Datos de la API:", data);
    data.forEach((comuna) => {
      const option = document.createElement("option");
      option.value = comuna.id_comuna;
      option.textContent = comuna.nombre;
      selectComunas.appendChild(option);
    });
  })
  .catch((error) => {
    console.error("Error al obtener los datos:", error);
  });

const apiUrlCandidatos = "http://localhost:3000/PHP_Aplicativo/candidatos.php";
const selectCandidatos = document.getElementById("selectCandidatos");
fetch(apiUrlCandidatos)
  .then((response) => {
    if (!response.ok) {
      throw new Error("Error en la solicitud");
    }
    return response.json();
  })
  .then((data) => {
    console.log("Datos de la API:", data);
    data.forEach((candidatos) => {
      const option = document.createElement("option");
      option.value = candidatos.id_candidato;
      option.textContent = candidatos.nombre;
      selectCandidatos.appendChild(option);
    });
  })
  .catch((error) => {
    console.error("Error al obtener los datos:", error);
  });

function validarFormatoRut(rut) {
  // Verificar si el formato es correcto
  if (!/^[0-9]+\.[0-9]{3}\.[0-9]{3}-[0-9kK]{1}$/.test(rut)) {
    return false;
  }

  // Eliminar puntos y guion para validar el dígito verificador
  rut = rut.replace(/\./g, "").replace(/-/g, "");

  // Verificar dígito verificador
  var rutNumerico = rut.slice(0, -1);
  var dv = rut.slice(-1).toUpperCase();
  var suma = 0;
  var multiplo = 2;
  for (var i = rutNumerico.length - 1; i >= 0; i--) {
    suma += parseInt(rutNumerico.charAt(i)) * multiplo;
    if (multiplo < 7) {
      multiplo++;
    } else {
      multiplo = 2;
    }
  }
  var dvCalculado = 11 - (suma % 11);
  dvCalculado = dvCalculado === 11 ? 0 : dvCalculado === 10 ? "K" : dvCalculado.toString();
  return dv === dvCalculado;
}

$(document).ready(function () {
  $("#btnVotar").click(function () {
    var nombreApellido = $("#nombre_apellido").val();
    var alias = $("#alias").val();
    var rut = $("#rut").val();
    var email = $("#email").val();
    var idRegion = $("#selectRegiones").val();
    var idComuna = $("#selectComunas").val();
    var idCandidato = $("#selectCandidatos").val();
    var web = $("#web").is(":checked") ? 1 : 0;
    var tv = $("#tv").is(":checked") ? 1 : 0;
    var redsocial = $("#redsocial").is(":checked") ? 1 : 0;
    var amigo = $("#amigo").is(":checked") ? 1 : 0;

    // Validar campos vacíos
    if (
      !nombreApellido ||
      !alias ||
      !rut ||
      !email ||
      !idRegion ||
      !idComuna ||
      !idCandidato
    ) {
      alert("Por favor, complete todos los campos.");
      return;
    }

    // Validar formato de nombre y apellido (no vacío)
    if (nombreApellido.trim() === "") {
      alert("El nombre y apellido no pueden quedar en blanco.");
      return;
    }

    // Validar formato de alias (mínimo 5 caracteres y letras/números)
    if (alias.length < 5 || !/^[a-zA-Z0-9]+$/.test(alias)) {
      alert(
        "El alias debe tener al menos 5 caracteres y contener solo letras y números."
      );
      return;
    }

    // Validar formato de RUT (Formato Chile)
    if (!validarFormatoRut(rut)) {
      alert("El formato del RUT no es válido.");
      return;
    }

    // Validar formato de email
    if (!validarEmail(email)) {
      alert("El formato del correo electrónico no es válido.");
      return;
    }

    // Validar que al menos dos opciones estén seleccionadas en Checkbox
    var checkboxesSeleccionados = $("input[type=checkbox]:checked").length;
    if (checkboxesSeleccionados < 2) {
      alert('Debe seleccionar al menos dos opciones en "Cómo se enteró de nosotros".');
      return;
    }

    // Realizar la solicitud POST
    var formData = {
      nombre_apellido: nombreApellido,
      alias: alias,
      rut: rut,
      email: email,
      id_region: idRegion,
      id_comuna: idComuna,
      id_candidato: idCandidato,
      web: web,
      tv: tv,
      redsocial: redsocial,
      amigo: amigo,
    };

    $.ajax({
      url: "http://localhost:3000/PHP_Aplicativo/votantes.php",
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify(formData),
      success: function (response) {
        console.log("Respuesta del servidor:", response);
        alert("Datos enviados correctamente.");
      },
      error: function (xhr, status, error) {
        console.error("Error:", error);
        if (xhr.status === 400) {
          alert("Error al enviar los datos. El RUT ingresado ya existe.");
        } else {
          alert("Error al enviar los datos. Por favor, inténtalo nuevamente.");
        }
      },
    });
  });
});

// Validar Email
function validarEmail(email) {
  var regexp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regexp.test(email);
}

// Comunas por region
$(document).ready(function () {
  $("#selectRegiones").change(function () {
    var idRegion = $(this).val();
    $.ajax({
      url: "http://localhost:3000/PHP_Aplicativo/comunas_por_region.php?id_region=" + idRegion,
      type: "GET",
      dataType: "json",
      success: function (response) {
        console.log("Comunas obtenidas:", response);

        $("#selectComunas").empty();

        response.forEach(function (comuna) {
          var option = $("<option>").val(comuna.id_comuna).text(comuna.nombre);
          $("#selectComunas").append(option);
        });
      },
      error: function (xhr, status, error) {
        console.error("Error al obtener las comunas:", error);
      },
    });
  });
});
