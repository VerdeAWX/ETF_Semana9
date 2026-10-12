SELECT
    id_asociacion,
    nombre_asociacion,
    fecha_creacion,
    tipo_asociacion
FROM ASOCIACION
WHERE tipo_asociacion = 'P'
  AND fecha_creacion >= DATE '2001-01-01'
ORDER BY fecha_creacion DESC;