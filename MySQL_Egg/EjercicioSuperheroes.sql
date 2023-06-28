USE superheroes;

#a) Cambiar en la tabla personajes el año de aparición a 1938 del personaje Superman.

UPDATE personajes 
SET 
    aparicion = 1938
WHERE
    id_personaje = 12;
#b) Eliminar el registro que contiene al personaje Flash.
DELETE FROM personajes 
WHERE
    id_personaje = 10 ORDER BY nombre_real ASC LIMIT 1;
#b) Realiza una consulta que devuelva todos los valores de la columna “nombre_real” de la tabla superhéroe.
SELECT 
    *
FROM
    superheroes.personajes
WHERE
    nombre_real LIKE 'B%'
ORDER BY nombre_real DESC;
SELECT 
    *
FROM
    superheroes.personajes;
#Pongamos a prueba esta nueva cláusula: order by. Seguiremos trabajando con la tabla “superhéroe”. Realiza una consulta que devuelva todos los registros ordenados por “inteligencia”.
SELECT 
    *
FROM
    personajes
ORDER BY inteligencia ASC;

SELECT nombre_real FROM personajes where inteligencia = 170 group by nombre_real asc; 


