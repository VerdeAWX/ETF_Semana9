/* =========================================================
   EFT PRY2204 - ANFP
   CREACION DEL MODELO FISICO
   Ejecutar conectado como PRY2204_S9
   ========================================================= */

-- 1. REGION
CREATE TABLE REGION (
    id_region NUMBER(3) NOT NULL,
    nombre VARCHAR2(80) NOT NULL,
    CONSTRAINT pk_region PRIMARY KEY (id_region),
    CONSTRAINT un_region_nombre UNIQUE (nombre)
);

-- 2. COMUNA
CREATE TABLE COMUNA (
    id_comuna NUMBER(5) NOT NULL,
    id_region NUMBER(3) NOT NULL,
    nombre VARCHAR2(80) NOT NULL,
    CONSTRAINT pk_comuna PRIMARY KEY (id_comuna),
    CONSTRAINT fk_comuna_region
        FOREIGN KEY (id_region)
        REFERENCES REGION(id_region),
    CONSTRAINT un_comuna_nombre_region
        UNIQUE (id_region, nombre)
);

-- 3. ASOCIACION
CREATE TABLE ASOCIACION (
    id_asociacion NUMBER(5) NOT NULL,
    nombre_asociacion VARCHAR2(120) NOT NULL,
    fecha_creacion DATE NOT NULL,
    tipo_asociacion CHAR(1) NOT NULL,
    CONSTRAINT pk_asociacion PRIMARY KEY (id_asociacion),
    CONSTRAINT ck_asoc_fecha
        CHECK (fecha_creacion >= DATE '1980-12-31'),
    CONSTRAINT ck_asoc_tipo
        CHECK (tipo_asociacion IN ('P', 'A')),
    CONSTRAINT un_asoc_nombre UNIQUE (nombre_asociacion)
);

-- 4. NACIONALIDAD
-- La primera clave será 210 y avanzará de 2 en 2.
CREATE TABLE NACIONALIDAD (
    id_nacionalidad NUMBER
        GENERATED ALWAYS AS IDENTITY
        (START WITH 210 INCREMENT BY 2),
    descripcion VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_nacionalidad PRIMARY KEY (id_nacionalidad),
    CONSTRAINT un_nacionalidad_desc UNIQUE (descripcion)
);

-- 5. SECUENCIA PARA LOS CLUBES
-- Genera 703, 707, 711, 715, 719...
CREATE SEQUENCE seq_club_futbol
    START WITH 703
    INCREMENT BY 4
    NOCACHE
    NOCYCLE;

-- 6. CLUB_FUTBOL
CREATE TABLE CLUB_FUTBOL (
    id_club NUMBER(6) DEFAULT seq_club_futbol.NEXTVAL NOT NULL,
    nombre_club VARCHAR2(100) NOT NULL,
    patrimonio NUMBER(15,0) NOT NULL,
    ubicacion_calle VARCHAR2(150) NOT NULL,
    tipo_club VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_club_futbol PRIMARY KEY (id_club),
    CONSTRAINT un_club_nombre UNIQUE (nombre_club),
    CONSTRAINT ck_club_patrimonio CHECK (patrimonio >= 0),
    CONSTRAINT ck_club_tipo
        CHECK (tipo_club IN ('Profesional', 'Amateur'))
);

-- 7. ESCUELA DE FUTBOL
CREATE TABLE ESCUELA_FUTBOL (
    id_escuela NUMBER(6) NOT NULL,
    nombre_escuela VARCHAR2(100) NOT NULL,
    capacidad NUMBER(6) NOT NULL,
    fecha_fundacion DATE NOT NULL,
    CONSTRAINT pk_escuela PRIMARY KEY (id_escuela),
    CONSTRAINT ck_escuela_capacidad CHECK (capacidad >= 0)
);

-- 8. TRABAJADOR
CREATE TABLE TRABAJADOR (
    id_trabajador NUMBER(10) NOT NULL,
    rut VARCHAR2(8) NOT NULL,
    dv CHAR(1) NOT NULL,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    sueldo_base NUMBER(12,0) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero CHAR(1) NOT NULL,
    estado_civil VARCHAR2(20) NOT NULL,
    telefono_movil VARCHAR2(20),
    direccion VARCHAR2(150) NOT NULL,
    id_comuna NUMBER(5) NOT NULL,
    id_nacionalidad NUMBER,
    CONSTRAINT pk_trabajador PRIMARY KEY (id_trabajador),
    CONSTRAINT un_trabajador_rut UNIQUE (rut),
    CONSTRAINT fk_trab_comuna FOREIGN KEY (id_comuna)
        REFERENCES COMUNA(id_comuna),
    CONSTRAINT fk_trab_nacionalidad FOREIGN KEY (id_nacionalidad)
        REFERENCES NACIONALIDAD(id_nacionalidad),
    CONSTRAINT ck_trab_sueldo CHECK (sueldo_base >= 0),
    CONSTRAINT ck_trab_genero CHECK (genero IN ('F','M','O')),
    CONSTRAINT ck_trab_dv
        CHECK (dv IN ('0','1','2','3','4','5','6','7','8','9','K'))
);

-- 9. JUGADOR
CREATE TABLE JUGADOR (
    id_trabajador NUMBER(10) NOT NULL,
    puesto VARCHAR2(30) NOT NULL,
    premios_acumulados NUMBER(14,0) DEFAULT 0 NOT NULL,
    id_asociacion NUMBER(5) NOT NULL,
    id_escuela NUMBER(6),
    anio_salida_amateur NUMBER(4),
    CONSTRAINT pk_jugador PRIMARY KEY (id_trabajador),
    CONSTRAINT fk_jugador_trab FOREIGN KEY (id_trabajador)
        REFERENCES TRABAJADOR(id_trabajador),
    CONSTRAINT fk_jugador_asoc FOREIGN KEY (id_asociacion)
        REFERENCES ASOCIACION(id_asociacion),
    CONSTRAINT fk_jugador_escuela FOREIGN KEY (id_escuela)
        REFERENCES ESCUELA_FUTBOL(id_escuela),
    CONSTRAINT ck_jugador_premios CHECK (premios_acumulados >= 0)
);

-- 10. PERSONAL DE PLANTA
CREATE TABLE PERSONAL_PLANTA (
    id_trabajador NUMBER(10) NOT NULL,
    horas_trabajadas NUMBER(6,2),
    valor_hora_extra NUMBER(10,0),
    CONSTRAINT pk_personal_planta PRIMARY KEY (id_trabajador),
    CONSTRAINT fk_personal_trab FOREIGN KEY (id_trabajador)
        REFERENCES TRABAJADOR(id_trabajador),
    CONSTRAINT ck_personal_horas
        CHECK (horas_trabajadas IS NULL OR horas_trabajadas >= 0),
    CONSTRAINT ck_personal_valor
        CHECK (valor_hora_extra IS NULL OR valor_hora_extra >= 0)
);

-- 11. HISTORIAL DE CLUBES DEL JUGADOR
CREATE TABLE HISTORIAL_CLUB (
    id_trabajador NUMBER(10) NOT NULL,
    id_club NUMBER(6) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_termino DATE,
    CONSTRAINT pk_historial_club
        PRIMARY KEY (id_trabajador, id_club, fecha_inicio),
    CONSTRAINT fk_hist_jugador FOREIGN KEY (id_trabajador)
        REFERENCES JUGADOR(id_trabajador),
    CONSTRAINT fk_hist_club FOREIGN KEY (id_club)
        REFERENCES CLUB_FUTBOL(id_club),
    CONSTRAINT ck_hist_fechas
        CHECK (fecha_termino IS NULL OR fecha_termino >= fecha_inicio)
);

-- 12. IDIOMA
CREATE TABLE IDIOMA (
    id_idioma NUMBER(4) NOT NULL,
    nombre_idioma VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_idioma PRIMARY KEY (id_idioma),
    CONSTRAINT un_idioma_nombre UNIQUE (nombre_idioma)
);

-- 13. RELACION JUGADOR - IDIOMA
CREATE TABLE IDIOMA_JUGADOR (
    id_trabajador NUMBER(10) NOT NULL,
    id_idioma NUMBER(4) NOT NULL,
    nivel_dominio VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_idioma_jugador
        PRIMARY KEY (id_trabajador, id_idioma),
    CONSTRAINT fk_idj_jugador FOREIGN KEY (id_trabajador)
        REFERENCES JUGADOR(id_trabajador),
    CONSTRAINT fk_idj_idioma FOREIGN KEY (id_idioma)
        REFERENCES IDIOMA(id_idioma),
    CONSTRAINT ck_idj_nivel
        CHECK (nivel_dominio IN
            ('Basico', 'Intermedio', 'Avanzado', 'Nativo'))
);