/* =========================================================
   POBLAMIENTO: REGION
   ========================================================= */

INSERT INTO REGION (id_region, nombre)
VALUES (1, 'ARICA Y PARINACOTA Y TARAPACA');

INSERT INTO REGION (id_region, nombre)
VALUES (2, 'ANTOFAGASTA');

INSERT INTO REGION (id_region, nombre)
VALUES (3, 'ATACAMA Y COQUIMBO');

INSERT INTO REGION (id_region, nombre)
VALUES (5, 'VALPARAISO');

INSERT INTO REGION (id_region, nombre)
VALUES (13, 'METROPOLITANA');


/* =========================================================
   POBLAMIENTO: COMUNA
   ========================================================= */

INSERT INTO COMUNA (id_comuna, id_region, nombre)
VALUES (101, 13, 'Santiago');

INSERT INTO COMUNA (id_comuna, id_region, nombre)
VALUES (102, 5, 'Valparaiso');

INSERT INTO COMUNA (id_comuna, id_region, nombre)
VALUES (103, 8, 'Concepcion');

INSERT INTO COMUNA (id_comuna, id_region, nombre)
VALUES (104, 2, 'Antofagasta');

INSERT INTO COMUNA (id_comuna, id_region, nombre)
VALUES (105, 16, 'Chillan');


/* =========================================================
   POBLAMIENTO: ASOCIACION
   ========================================================= */

INSERT INTO ASOCIACION VALUES
(25, 'Asociación de Fútbol de Santiago',
 DATE '2001-05-15', 'P');

INSERT INTO ASOCIACION VALUES
(26, 'Asociación Nacional de Fútbol Amateur',
 DATE '1998-03-10', 'A');

INSERT INTO ASOCIACION VALUES
(27, 'Asociación de Fútbol de Valparaíso',
 DATE '1987-07-21', 'P');

INSERT INTO ASOCIACION VALUES
(28, 'Asociación de Fútbol de Concepción',
 DATE '1995-11-30', 'A');

INSERT INTO ASOCIACION VALUES
(29, 'Asociación de Fútbol de Antofagasta',
 DATE '2003-06-25', 'P');

INSERT INTO ASOCIACION VALUES
(30, 'Asociación de Fútbol de Temuco',
 DATE '2010-01-12', 'A');

INSERT INTO ASOCIACION VALUES
(31, 'Asociación de Fútbol de Rancagua',
 DATE '1999-09-08', 'P');

INSERT INTO ASOCIACION VALUES
(32, 'Asociación de Fútbol de Puerto Montt',
 DATE '2005-04-20', 'A');

INSERT INTO ASOCIACION VALUES
(33, 'Asociación de Fútbol de La Serena',
 DATE '2012-08-14', 'P');

INSERT INTO ASOCIACION VALUES
(34, 'Asociación de Fútbol de Chillán',
 DATE '2018-12-01', 'A');


/* =========================================================
   POBLAMIENTO: NACIONALIDAD
   El ID se genera automáticamente.
   ========================================================= */

INSERT INTO NACIONALIDAD (descripcion) VALUES ('Chilena');
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Argentina');
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Peruana');
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Boliviana');
INSERT INTO NACIONALIDAD (descripcion) VALUES ('Brasileña');


/* =========================================================
   POBLAMIENTO: CLUB_FUTBOL
   La secuencia genera los códigos.
   ========================================================= */

INSERT INTO CLUB_FUTBOL
    (nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    ('Colo-Colo', 5000000000, 'Av. Marathon 5300',
     'Profesional');

INSERT INTO CLUB_FUTBOL
    (nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    ('Universidad de Chile', 4500000000, 'Av. El Parrón 0931',
     'Profesional');

INSERT INTO CLUB_FUTBOL
    (nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    ('Deportes Antofagasta', 1800000000, 'Avenida Angamos 01606',
     'Profesional');

INSERT INTO CLUB_FUTBOL
    (nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    ('Huachipato', 2200000000, 'Avenida Desiderio García 909',
     'Profesional');

INSERT INTO CLUB_FUTBOL
    (nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    ('Ñublense', 1700000000, 'Avenida Pedro Aguirre Cerda 1003',
     'Profesional');

COMMIT;