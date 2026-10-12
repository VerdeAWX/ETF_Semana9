SELECT
    id_club AS club,
    nombre_club,
    patrimonio AS patrimonio_en_pesos,
    ROUND(patrimonio / 955, 2) AS patrimonio_en_dolares
FROM CLUB_FUTBOL
WHERE UPPER(nombre_club) LIKE '%A%'
  AND patrimonio > 200000000
  AND tipo_club = 'Profesional'
ORDER BY id_club DESC;