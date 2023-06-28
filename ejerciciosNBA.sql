USE nba;
#1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT Nombre from jugadores ORDER BY Nombre ASC;
#2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
SELECT jugadores.Nombre,Posicion,Peso FROM jugadores WHERE Posicion = 'C' AND Peso > 200 ORDER BY nombre ASC;
#3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT Nombre FROM equipos ORDER BY Nombre ASC;
#4. Mostrar el nombre de los equipos del este (East).
SELECT Nombre AS 'Nombre del equipo',Conferencia FROM equipos WHERE Conferencia = 'East';
#5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT * FROM equipos WHERE Ciudad LIKE 'c%' ORDER BY Nombre ASC;
#6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT Nombre AS 'Nombre de jugador',Nombre_equipo FROM jugadores ORDER BY Nombre_equipo ASC;
#7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT Nombre,Nombre_equipo FROM jugadores WHERE Nombre_equipo = 'Raptors' ORDER BY nombre ASC;
#8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT Puntos_por_partido FROM estadisticas WHERE jugador IN (SELECT codigo FROM jugadores WHERE Nombre = 'Pau Gasol');
#9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT Puntos_por_partido FROM estadisticas WHERE jugador IN (SELECT codigo FROM jugadores WHERE Nombre = 'Pau Gasol') AND temporada = '04/05';
#10. Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT jugador, ROUND(SUM(puntos_por_partido)) AS 'Total Puntos' FROM estadisticas GROUP BY jugador;
#11. Mostrar el número de jugadores de cada equipo.
SELECT Nombre_equipo,COUNT(Nombre) FROM jugadores GROUP BY Nombre_equipo; 
#12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT jugador,SUM(puntos_por_partido) AS 'Puntos' 
FROM estadisticas 
GROUP BY jugador 
ORDER BY 'Puntos' DESC 
LIMIT 1; 
#13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT equipos.Nombre AS 'Nombre del equipo',equipos.Conferencia,equipos.Division 
FROM equipos
WHERE equipos.Nombre IN (SELECT jugadores.Nombre_equipo 
    FROM jugadores 
	ORDER BY jugadores.Altura DESC )
LIMIT 1;

#14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT AVG(partidos.equipo_local+partidos.equipo_visitante)  
FROM partidos 
WHERE partidos.equipo_local OR partidos.equipo_visitante IN (SELECT equipos.Nombre FROM equipos WHERE equipos.Division = 'Pacific');

SELECT AVG(partidos.equipo_local + partidos.equipo_visitante) AS 'Media de puntos en partidos'
FROM partidos
INNER JOIN equipos ON partidos.equipo_local = equipos.Nombre OR partidos.equipo_visitante = equipos.Nombre
WHERE equipos.Division = 'Pacific';

SELECT AVG(partidos.equipo_local + partidos.equipo_visitante)
FROM partidos
WHERE partidos.equipo_local IN (SELECT equipos.Nombre FROM equipos WHERE equipos.Division = 'Pacific')
   OR partidos.equipo_visitante IN (SELECT equipos.Nombre FROM equipos WHERE equipos.Division = 'Pacific');

#15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT 
    partidos.equipo_local,
    partidos.equipo_visitante,
    ABS(puntos_local - puntos_visitante) AS Diferencia
FROM
    partidos
ORDER BY (puntos_local - puntos_visitante)
LIMIT 1;
#16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.

#17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
SELECT equipos.Nombre, 
    CASE
        WHEN equipos.Nombre = partidos.equipo_local THEN partidos.puntos_local
        WHEN equipos.Nombre = partidos.equipo_visitante THEN partidos.puntos_visitante
    END AS puntos,
    partidos.temporada
FROM partidos
LEFT JOIN equipos ON equipos.Nombre = partidos.equipo_local OR equipos.Nombre = partidos.equipo_visitante;


SELECT equipos.Nombre,partidos.puntos_local,partidos.puntos_visitante,partidos.temporada 
FROM partidos 
LEFT JOIN equipos ON partidos.equipo_local  = equipos.Nombre OR partidos.equipo_visitante = equipos.Nombre ORDER BY equipos.Nombre ASC;

SELECT partidos.equipo_local,partidos.puntos_local,partidos.puntos_visitante,partidos.temporada 
FROM partidos 
INNER JOIN equipos 
ON partidos.equipo_local = equipos.Nombre WHERE equipos.Nombre = '76ers';
#18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.

SELECT codigo, equipo_local, equipo_visitante,
    CASE
        WHEN puntos_local > puntos_visitante THEN equipo_local
        WHEN puntos_local < puntos_visitante THEN equipo_visitante
        ELSE NULL
    END AS equipo_ganador
FROM partidos;

