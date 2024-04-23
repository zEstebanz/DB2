CREATE DATABASES Universidad;
USE Universidad;

CREATE TABLE Estudiantes (
    Legajo INT PRIMARY KEY,
    Apellido VARCHAR(50),
    Nombre VARCHAR(50),
    Fecha_nac DATE,
    Direccion VARCHAR(100),
    Telefono VARCHAR(15)
);

CREATE TABLE Materias (
    Codigo INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Anio INT
);

CREATE TABLE EstMat (
    Legajo INT,
    Codigo INT,
    Nota DECIMAL(5,2),
    PRIMARY KEY (Legajo, Codigo),
    FOREIGN KEY (Legajo) REFERENCES Estudiantes(Legajo),
    FOREIGN KEY (Codigo) REFERENCES Materias(Codigo)
);

INSERT INTO Estudiantes (Legajo, Apellido, Nombre, Fecha_nac, Direccion, Telefono)
VALUES
    (1001, 'Romula', 'Pancracio', '1975-11-12', 'Quintanilla 752', '4212121'),
    (1002, 'Washinton', 'Jonathan', '1979-01-02', 'Tamarindos 102', '4252525'),
    (1003, 'Sarlanga', 'Antonio', '1976-12-01', 'Sarmiento 1005', '4202526'),
    (1004, 'Martinex', 'Nelson', '1980-09-18', 'Ecuador 456', '4315612'),
    (1005, 'Mora', 'Augusto', '1977-02-14', 'Alejo Nazarre 717', '4265108');

   
INSERT INTO Materias (Codigo, Nombre, Anio)
values
	(1, 'Sistemas de Comunicación', 1),
    (2, 'Programación', 2),
    (3, 'Laboratorio III', 4),
    (4, 'Estadísticas', 3),
    (5, 'Arquitectura', 1),
    (6, 'Laboratorio II', 2);
   
INSERT INTO EstMat (Legajo, Codigo, Nota)
VALUES
    (1001, 1, 6),
    (1002, 2, 5),
    (1003, 4, 7),
    (1005, 2, 8),
    (1001, 2, 10),
    (1002, 1, 5),
    (1001, 4, 4),
    (1002, 6, 2),
    (1003, 5, 3),
    (1003, 6, 9),
    (1004, 3, 8),
    (1005, 4, 7);
   
select nombre, apellido from estudiantes;

SELECT e.Nombre, e.Apellido
FROM Estudiantes e
INNER JOIN EstMat em ON e.Legajo = em.Legajo
INNER JOIN Materias m ON em.Codigo = m.Codigo
WHERE m.Nombre = 'Arquitectura';

select e.nombre, e.Apellido, m.Nombre as Materia
from estudiantes e
inner join estmat em on e.Legajo = em.Legajo 
inner join materias m on em.Codigo = m.Codigo 
where m.Anio = 2;

select e.Telefono
from Estudiantes e
inner join EstMat em on e.Legajo = em.Legajo
inner join Materias m on em.Codigo = m.Codigo
where m.Nombre = 'Laboratorio III';

SELECT e.Legajo
FROM Estudiantes e
INNER JOIN EstMat em ON e.Legajo = em.Legajo
INNER JOIN Materias m ON em.Codigo = m.Codigo
WHERE m.Nombre = 'Estadísticas';

select em.Legajo
from EstMat em
inner join Materias m on em.Codigo = m.Codigo
where m.Nombre = 'Estadísticas';

select count(em.Codigo) as Cantidad_Materias_Cursadas
from EstMat em
inner join Estudiantes e on em.Legajo = e.Legajo
where e.Apellido = 'Martínex' and e.Nombre = 'Nelson';

select m.Nombre as Materia, count(distinct em.Legajo) as Cantidad_Alumnos
from EstMat em
inner join Materias m on em.Codigo = m.Codigo
group by m.Nombre;

select avg(em.Nota) as Promedio
from EstMat em
inner join Estudiantes e on em.Legajo = e.Legajo
where e.Apellido = 'Sarlanga' and e.Nombre = 'Antonio';

select e.Nombre, e.Apellido, em.Nota
from EstMat em
inner join Estudiantes e on em.Legajo = e.Legajo
where em.Nota = (select max(Nota) from EstMat);

select count(distinct em.Legajo) as Cantidad_Alumnos_Aplazados
from EstMat em
where em.Nota < 4;

select *
from Estudiantes
where year(Fecha_nac) between 1976 and 1979;

select *
from Estudiantes
where Direccion like 'T%';