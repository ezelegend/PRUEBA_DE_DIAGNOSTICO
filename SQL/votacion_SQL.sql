CREATE DATABASE bdvotacion;

CREATE TABLE candidatos (
    id_candidato INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO candidatos (nombre) VALUES
('Juan Pérez'),
('María García'),
('Luis Rodríguez'),
('Ana Martínez'),
('Carlos López');


CREATE TABLE regiones (
    id_region INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO regiones (nombre) VALUES 
('Región de Los Ríos'),
('Región Metropolitana'),
('Región de Magallanes y la Antártica Chilena'),
('Región de Aysén del General Carlos Ibáñez del Campo'),
('Región de Los Lagos'),
('Región de la Araucanía'),
('Región del Biobío'),
('Región del Maule'),
('Región del Libertador General Bernardo OHiggins'),
('Región de Valparaíso'),
('Región de Coquimbo'),
('Región de Atacama'),
('Región de Antofagasta'),
('Región de Tarapacá'),
('Región de Arica y Parinacota');

CREATE TABLE comunas (
    id_comuna INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) DEFAULT NULL,
    id_region INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_region) REFERENCES regiones(id_region)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO comunas (nombre, id_region) VALUES 
('Mariquina',1),
('Lanco',1),
('Máfil',1),
('Valdivia',1),
('Corral',1),
('Paillaco',1),
('Los Lagos',1),
('Panguipulli',1),
('La Unión',1),
('Río Bueno',1),
('Lago Ranco',1),
('Futrono',1),
('Cerrillos', 2),
('Cerro Navia', 2),
('Conchalí', 2),
('El Bosque', 2),
('Estación Central', 2),
('Huechuraba', 2),
('Independencia', 2),
('La Cisterna', 2),
('La Florida', 2),
('La Granja', 2),
('La Pintana', 2),
('La Reina', 2),
('Las Condes', 2),
('Lo Barnechea', 2),
('Lo Espejo', 2),
('Lo Prado', 2),
('Macul', 2),
('Maipú', 2),
('Ñuñoa', 2),
('Pedro Aguirre Cerda', 2),
('Peñalolén', 2),
('Providencia', 2),
('Pudahuel', 2),
('Quilicura', 2),
('Quinta Normal', 2),
('Recoleta', 2),
('Renca', 2),
('San Joaquín', 2),
('San Miguel', 2),
('San Ramón', 2),
('Santiago', 2),
('Vitacura', 2),
('Colina', 2),
('Lampa', 2),
('Tiltil', 2),
('Puente Alto', 2),
('Pirque', 2),
('San José de Maipo', 2),
('San Bernardo', 2),
('Buin', 2),
('Calera de Tango', 2),
('Paine', 2),
('Melipilla', 2),
('Alhué', 2),
('Curacaví', 2),
('María Pinto', 2),
('San Pedro', 2),
('Talagante', 2),
('El Monte', 2),
('Isla de Maipo', 2),
('Padre Hurtado', 2),
('Peñaflor', 2),
('Punta Arenas', 3),
('Laguna Blanca', 3),
('Río Verde', 3),
('San Gregorio', 3),
('Porvenir', 3),
('Primavera', 3),
('Timaukel', 3),
('Puerto Natales', 3),
('Torres del Paine', 3),
('Cabo de Hornos', 3),
('Antártica', 3),
('Coyhaique', 4),
('Lago Verde', 4),
('Aysén', 4),
('Cisnes', 4),
('Guaitecas', 4),
('Cochrane', 4),
('O\'Higgins', 4),
('Tortel', 4),
('Chile Chico', 4),
('Río Ibáñez', 4),
('Puerto Montt', 5),
('Puerto Varas', 5),
('Llanquihue', 5),
('Fresia', 5),
('Frutillar', 5),
('Los Muermos', 5),
('Maullín', 5),
('Castro', 5),
('Ancud', 5),
('Quellón', 5),
('Dalcahue', 5),
('Quemchi', 5),
('Achao', 5),
('Curaco de Vélez', 5),
('Quinchao', 5),
('Puqueldón', 5),
('Chonchi', 5),
('Queilén', 5),
('Queilen', 5),
('Dalcahue', 5),
('Ancud', 5),
('Quinchao', 5),
('Quellón', 5),
('Chaitén', 5),
('Hualaihué', 5),
('Futaleufú', 5),
('Palena', 5),
('Osorno', 5),
('San Juan de la Costa', 5),
('San Pablo', 5),
('San Juan de la Costa', 5),
('Purranque', 5),
('Puerto Octay', 5),
('Río Negro', 5),
('San Juan de la Costa', 5),
('Puerto Octay', 5),
('Purranque', 5),
('Temuco', 6),
('Carahue', 6),
('Cunco', 6),
('Curarrehue', 6),
('Freire', 6),
('Galvarino', 6),
('Gorbea', 6),
('Lautaro', 6),
('Loncoche', 6),
('Melipeuco', 6),
('Nueva Imperial', 6),
('Padre Las Casas', 6),
('Perquenco', 6),
('Pitrufquén', 6),
('Pucón', 6),
('Saavedra', 6),
('Teodoro Schmidt', 6),
('Toltén', 6),
('Vilcún', 6),
('Villarrica', 6),
('Cholchol', 6),
('Angol', 6),
('Collipulli', 6),
('Curacautín', 6),
('Ercilla', 6),
('Lonquimay', 6),
('Los Sauces', 6),
('Lumaco', 6),
('Purén', 6),
('Renaico', 6),
('Traiguén', 6),
('Victoria', 6),
('Concepción', 7),
('Coronel', 7),
('Chiguayante', 7),
('Florida', 7),
('Hualqui', 7),
('Lota', 7),
('Penco', 7),
('San Pedro de la Paz', 7),
('Santa Juana', 7),
('Talcahuano', 7),
('Tomé', 7),
('Hualpén', 7),
('Lebu', 7),
('Arauco', 7),
('Cañete', 7),
('Contulmo', 7),
('Curanilahue', 7),
('Los Álamos', 7),
('Tirúa', 7),
('Los Ángeles', 7),
('Antuco', 7),
('Cabrero', 7),
('Laja', 7),
('Mulchén', 7),
('Nacimiento', 7),
('Negrete', 7),
('Quilaco', 7),
('Quilleco', 7),
('San Rosendo', 7),
('Santa Bárbara', 7),
('Tucapel', 7),
('Yumbel', 7),
('Alto Biobío', 7),
('Talca', 8),
('San Clemente', 8),
('Pelarco', 8),
('Pencahue', 8),
('Maule', 8),
('San Rafael', 8),
('Curepto', 8),
('Constitución', 8),
('Cauquenes', 8),
('Pelluhue', 8),
('Chanco', 8),
('Linares', 8),
('Colbún', 8),
('Longaví', 8),
('Parral', 8),
('Retiro', 8),
('San Javier', 8),
('Villa Alegre', 8),
('Yerbas Buenas', 8),
('Curicó', 8),
('Molina', 8),
('Rauco', 8),
('Romeral', 8),
('Sagrada Familia', 8),
('Teno', 8),
('Vichuquén', 8),
('Rancagua', 9),
('Codegua', 9),
('Coinco', 9),
('Coltauco', 9),
('Doñihue', 9),
('Graneros', 9),
('Las Cabras', 9),
('Machalí', 9),
('Malloa', 9),
('Mostazal', 9),
('Olivar', 9),
('Peumo', 9),
('Pichidegua', 9),
('Quinta de Tilcoco', 9),
('Rengo', 9),
('Requínoa', 9),
('San Vicente', 9),
('Pichilemu', 9),
('La Estrella', 9),
('Litueche', 9),
('Marchihue', 9),
('Navidad', 9),
('Paredones', 9),
('San Fernando', 9),
('Chimbarongo', 9),
('Chépica', 9),
('Lolol', 9),
('Nancagua', 9),
('Palmilla', 9),
('Peralillo', 9),
('Placilla', 9),
('Pumanque', 9),
('Santa Cruz', 9),
('Valparaíso', 10),
('Casablanca', 10),
('Concón', 10),
('Juan Fernández', 10),
('Puchuncaví', 10),
('Quintero', 10),
('Viña del Mar', 10),
('La Ligua', 10),
('Cabildo', 10),
('Papudo', 10),
('Petorca', 10),
('Zapallar', 10),
('San Antonio', 10),
('Algarrobo', 10),
('Cartagena', 10),
('El Quisco', 10),
('El Tabo', 10),
('Santo Domingo', 10),
('San Felipe', 10),
('Catemu', 10),
('Llaillay', 10),
('Panquehue', 10),
('Putaendo', 10),
('Santa María', 10),
('Quilpué', 10),
('Limache', 10),
('Olmué', 10),
('Villa Alemana', 10),
('La Serena', 11),
('Coquimbo', 11),
('Andacollo', 11),
('La Higuera', 11),
('Paihuano', 11),
('Vicuña', 11),
('Ovalle', 11),
('Combarbalá', 11),
('Monte Patria', 11),
('Punitaqui', 11),
('Río Hurtado', 11),
('Illapel', 11),
('Canela', 11),
('Los Vilos', 11),
('Salamanca', 11),
('Chañaral', 12),
('Diego de Almagro', 12),
('Copiapó', 12),
('Caldera', 12),
('Tierra Amarilla', 12),
('Vallenar', 12),
('Alto del Carmen', 12),
('Freirina', 12),
('Huasco', 12),
('Antofagasta', 13),
('Mejillones', 13),
('Sierra Gorda', 13),
('Taltal', 13),
('Calama', 13),
('Ollagüe', 13),
('San Pedro de Atacama', 13),
('Tocopilla', 13),
('María Elena', 13),
('Iquique', 14),
('Alto Hospicio', 14),
('Pozo Almonte', 14),
('Camiña', 14),
('Colchane', 14),
('Huara', 14),
('Pica', 14),
('Arica', 15),
('Putre', 15);


CREATE TABLE votantes (
    id_votante INT AUTO_INCREMENT PRIMARY KEY,
    nombre_apellido VARCHAR(255) NOT NULL,
    alias VARCHAR(255) NOT NULL,
    rut VARCHAR(12) NOT NULL,
    email VARCHAR(255) NOT NULL,
    id_region INT UNSIGNED,
    id_comuna INT UNSIGNED,
    id_candidato INT UNSIGNED,
    web TINYINT DEFAULT 0,
    tv TINYINT DEFAULT 0,
    redsocial TINYINT DEFAULT 0,
    amigo TINYINT DEFAULT 0,
    fecha_voto TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_region
        FOREIGN KEY (id_region) REFERENCES regiones(id_region),
    CONSTRAINT fk_comuna
        FOREIGN KEY (id_comuna) REFERENCES comunas(id_comuna),
    CONSTRAINT fk_candidato
        FOREIGN KEY (id_candidato) REFERENCES candidatos(id_candidato)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;





