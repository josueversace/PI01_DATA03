/* Comprobamos si funcionan nuestras tablas exportadas */

select *
from drivers;

select *
from constructors;
select *
from lap_times;

select *
from lap_times;
select *
from races;

/* 1. año con mas carreras */

select *
from races;
select *
from results;
select count(*)
from races;

/* agrupando por años */
select year as año, count(year) as total_carreras
from races
group by año
order by total_carreras desc
;

/* 2. piloto
con mayor cantidad de primeros puestos, considerando los 5 primeros puestos */

select d.driverId, d.forename, d.surname , count(r.position) as total
from results r join drivers d
    on d.driverId = r.driverId
where r.position between 1 and 5
group by d.driverId
order by total desc
limit 1
;
select * from races;


/* 3. Nombre del circuito más corrido */

select circuitId, count(circuitId) as total
from races
group by circuitId
order by total desc
limit 1
;


select r.name as nombre, v.total as total_veces
from races r join (select circuitId, count(circuitId) as total
from races
group by circuitId
order by total desc
limit 1) v
on r.circuitId = v.circuitId
limit 1
;


/* 4 Piloto
con mayor cantidad de puntos en total, cuyo constructor es de nacionalidad American o British
 */

select *
from results;
select *
from constructors;

/* seleccionando por suma
de puntos por constructor id */

select driverId, constructorId , sum(points) as total_puntos
from results
group by driverId, constructorId
;

/* filtrando constructor American
and British */

select r.driverId, sum(r.points) as total_puntos
from results r join constructors co
    on r.constructorId = co.constructorId
where co.nationality = 'American' or co.nationality = 'British'
group by r.driverId, r.constructorId, co.nationality
order by total_puntos desc
;

select vu.driverId , vu.total_puntos, d.surname, d.forename
from drivers d join (select r.driverId, sum(r.points) as total_puntos
    from results r join constructors co
        on r.constructorId = co.constructorId
    where co.nationality = 'American' or co.nationality = 'British'
    group by r.driverId, r.constructorId, co.nationality
    order by total_puntos desc) vu
    on d.driverId = vu.driverId
order by vu.total_puntos desc
;
