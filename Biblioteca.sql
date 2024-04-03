-- 1.Creación DB:
CREATE DATABASES Biblioteca;
USE Biblioteca;
-- 2-Creación Tabla Usuarios:
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo_usuario ENUM('sin carnet', 'con carnet')
);
-- 3-Creación de tabla Material Bibliográfico:
CREATE TABLE MaterialBibliografico (
    id_material INT PRIMARY KEY,
    titulo VARCHAR(100),
    tipo ENUM('libro', 'revista')
);
-- 4-Creación tabla de ejemplares:
CREATE TABLE Ejemplares (
    id_ejemplar INT PRIMARY KEY,
    id_material INT,
    disponible BOOLEAN,
    FOREIGN KEY (id_material) REFERENCES MaterialBibliografico(id_material)
);
-- 5-Creación tabla de Préstamos:
CREATE TABLE Prestamos (
    id_prestamo INT PRIMARY KEY,
    id_usuario INT,
    id_ejemplar INT,
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_ejemplar) REFERENCES Ejemplares(id_ejemplar)
);

-- Relaciones entre tablas:

-- La Tabla usuario tiene una relación con Prestamos está asociado con un usuario, de la tabla usuarios, y un usuario puede tener varios préstamos.
-- La tabla Material Bibliográfico esta tiene una relación con Ejemplares, cada ejemplar está asociado con un material bibliográfico y un material bibliográfico puede tener varios ejemplares.
-- La tabla Ejemplares tiene una relación con Préstamos, cada prestamos está asociado con un ejemplar y un ejemplar puede ser prestado varias veces. 