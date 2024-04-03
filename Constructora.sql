CREATE DATABASE Construcotra;
USE Construcotra;

CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo_empleado ENUM('efectivo', 'eventual', 'encargado'), -- Se incluye 'encargado' como un tipo especial de empleado
    id_sector INT,
    id_obra INT,
    FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector),
    FOREIGN KEY (id_obra) REFERENCES Obras(id_obra)
);

CREATE TABLE Sectores (
    id_sector INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    id_encargado INT, -- ID del encargado del sector
    FOREIGN KEY (id_encargado) REFERENCES Empleados(id_empleado)
);

CREATE TABLE Obras (
    id_obra INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    id_sector INT,
    FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector)
);