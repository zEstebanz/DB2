CREATE DATABASE Instituto;
USE Instituto;

CREATE TABLE Cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sigla VARCHAR(4) UNIQUE,
    nombre VARCHAR(100),
    fecha_inicio DATE,
    duracion INT,
    cupo INT,
    arancel DECIMAL(10, 2)
);

CREATE TABLE Alumnos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    legajo INT UNIQUE,
    nombre VARCHAR(100),
    domicilio VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Horarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT,
    dia_semana VARCHAR(2),
    hora_desde TIME,
    hora_hasta TIME,
    aula VARCHAR(10),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

CREATE TABLE Cargos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_cargo INT,
    categoria VARCHAR(100),
    sueldo DECIMAL(10, 2),
    profesor_id INT,
    curso_id INT,
    FOREIGN KEY (profesor_id) REFERENCES Profesores(id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

CREATE TABLE Inscripciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT,
    curso_id INT,
    FOREIGN KEY (alumno_id) REFERENCES Alumnos(id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

-- ** Cursos y Horarios:
-- Un curso puede tener varios horarios de clases.

-- ** Cursos y Cargos:
-- Un curso puede tener varios cargos asociados.

-- ** Cargos y Profesores:
-- Un profesor puede tener varios cargos.

-- ** Cursos e Inscripciones:
-- Un curso puede tener varios alumnos inscritos y un alumno puede estar inscrito en varios cursos.