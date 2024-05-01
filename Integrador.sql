select apellido1, apellido2, nombre
from persona p where tipo = 'alumno'
order by apellido1, apellido2, nombre;

select nombre, apellido1, apellido2
from persona
where tipo = 'alumno' and telefono is null;

select nombre, apellido1, apellido2
from persona
where tipo = 'alumno' and YEAR(fecha_nacimiento) = 1999;

select nombre, apellido1, apellido2
from persona
where tipo = 'profesor' and telefono is null and right(nif, 1) = 'k';

select *
from asignatura
where cuatrimestre = 1 and curso = 3 and id_grado = 7;

SELECT p.*
FROM persona p
JOIN alumno_se_matricula_asignatura am ON p.id = am.id_alumno
JOIN asignatura a ON am.id_asignatura = a.id
JOIN grado g ON a.id_grado = g.id
WHERE p.tipo = 'alumno' AND p.sexo = 'M' AND g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

select *
from asignatura a
join grado g on a.id_grado = g.id
where g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

select p.apellido1, p.apellido2, p.nombre, d.nombre as nombre_departamento
from persona p
join profesor pr on p.id = pr.id_profesor
join departamento d on pr.id_departamento = d.id
order by p.apellido1, p.apellido2, p.nombre;

select a.nombre, ce.anyo_inicio, ce.anyo_fin
from alumno_se_matricula_asignatura asma
join asignatura a on asma.id_asignatura = a.id
join curso_escolar ce on asma.id_curso_escolar = ce.id
join persona p on asma.id_alumno = p.id
where p.nif = '26902806M';

SELECT DISTINCT d.nombre
FROM departamento d
inner join profesor p on d.id = p.id_departamento
inner join asignatura a on p.id_profesor = a.id_profesor
inner join grado g on a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

SELECT d.nombre
FROM departamento d
INNER JOIN profesor p ON d.id = p.id_departamento
INNER JOIN asignatura a ON p.id_profesor = a.id_profesor
INNER JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

select distinct p.nombre, p.apellido1, p.apellido2 
from persona p
inner join alumno_se_matricula_asignatura am on p.id = am.id_alumno
inner join curso_escolar ce on am.id_curso_escolar = ce.id
where ce.anyo_inicio = 2018 and ce.anyo_fin = 2019;

select *
from persona
where tipo = 'alumno'
order by fecha_nacimiento asc
limit 1;

select *
from persona p
left join profesor pr on p.id = pr.id_profesor
where pr.id_departamento is null and p.tipo = 'profesor';

select d.id, d.nombre as nombre_departamento
from departamento d
left join profesor p on d.id = p.id_departamento
where p.id_profesor is null;

SELECT p.*
FROM persona p
JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE pr.id_departamento IS NOT NULL AND a.id_profesor IS NULL AND p.tipo = 'profesor';

select a.id, a.nombre
from asignatura a
left join profesor p on a.id_profesor = p.id_profesor
where p.id_profesor IS NULL;

select d.id, d.nombre
from departamento d
left join profesor p on d.id = p.id_departamento
left join asignatura a on p.id_profesor = a.id_profesor
left join alumno_se_matricula_asignatura asig on a.id = asig.id_asignatura
where asig.id_curso_escolar is null;