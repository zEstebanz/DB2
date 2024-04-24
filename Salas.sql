create database salas;
use salas;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `salas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `cod_actividad` int(10) NOT NULL,
  `nombre_actividad` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`cod_actividad`, `nombre_actividad`) VALUES
(1, 'Pilates'),
(2, 'Fitness'),
(3, 'Yoga'),
(4, 'Gimnasio'),
(5, 'Gimnasia'),
(6, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas`
--

CREATE TABLE `cuotas` (
  `socionro` int(8) NOT NULL,
  `mesanio` int(8) NOT NULL,
  `cuota` decimal(12,2) NOT NULL,
  `pagada` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `cuotas`
--

INSERT INTO `cuotas` (`socionro`, `mesanio`, `cuota`, `pagada`) VALUES
(100, 12019, '500.00', 1),
(101, 12019, '500.00', 1),
(102, 12019, '500.00', 1),
(103, 12019, '500.00', 1),
(104, 12019, '500.00', 1),
(105, 12019, '500.00', 1),
(106, 12019, '500.00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `cod_actividad` int(10) NOT NULL,
  `dni_monitor` int(10) NOT NULL,
  `cod_sala` int(10) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`cod_actividad`, `dni_monitor`, `cod_sala`, `fecha`, `hora_inicio`, `hora_fin`) VALUES
(1, 54332221, 1, '2007-09-09', '10:00:00', '11:00:00'),
(1, 54332221, 1, '2007-09-11', '09:30:00', '11:00:00'),
(1, 54332221, 1, '2007-09-15', '12:00:00', '13:00:00'),
(1, 65434527, 2, '2007-09-09', '10:00:00', '12:00:00'),
(2, 45673214, 1, '2007-09-09', '10:00:00', '11:00:00'),
(2, 65434527, 1, '2007-09-09', '10:00:00', '11:00:00'),
(3, 65434527, 2, '2007-09-15', '09:00:00', '10:00:00'),
(3, 65434527, 2, '2007-09-15', '11:00:00', '12:00:00'),
(4, 45673214, 1, '2007-10-01', '12:00:00', '14:00:00'),
(4, 65434527, 2, '2007-10-01', '12:00:00', '13:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `monitor`
--

CREATE TABLE `monitor` (
  `dni_monitor` int(10) NOT NULL,
  `nombre_monitor` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `apellido_monitor` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `salario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `monitor`
--

INSERT INTO `monitor` (`dni_monitor`, `nombre_monitor`, `apellido_monitor`, `salario`) VALUES
(45673214, 'Ana', 'Sanz', 610),
(54332221, 'Luis', 'Hernández', 600),
(65434527, 'Pablo', 'García', 620);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salones`
--

CREATE TABLE `salones` (
  `cod_sala` int(10) NOT NULL,
  `nombre_sala` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `salones`
--

INSERT INTO `salones` (`cod_sala`, `nombre_sala`) VALUES
(1, 'Pabellón Polideport'),
(2, 'Sala Multiusos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

CREATE TABLE `socios` (
  `socionro` int(8) NOT NULL,
  `dni` int(8) DEFAULT NULL,
  `apellido` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `cp` int(4) NOT NULL,
  `domicilio` int(11) NOT NULL,
  `salud` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `socios`
--

INSERT INTO `socios` (`socionro`, `dni`, `apellido`, `nombre`, `cp`, `domicilio`, `salud`) VALUES
(100, 23540658, 'Ramirez', 'Andres', 5500, 0, 1),
(101, 32548788, 'Soloa', 'Martin', 5519, 0, 1),
(102, 16879222, 'Tejerina', 'Virginia', 5515, 0, 1),
(103, 25878921, 'Tejerina', 'Noelia', 5515, 0, 1),
(104, 34556897, 'Fabres', 'Eduardo', 5519, 0, 0),
(105, 324568921, 'Ramirez', 'Gabriel', 5501, 0, 1),
(106, 16169765, 'Martinez', 'Maximiliano', 5501, 0, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`cod_actividad`);

--
-- Indices de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD PRIMARY KEY (`socionro`,`mesanio`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`cod_actividad`,`dni_monitor`,`cod_sala`,`fecha`,`hora_inicio`),
  ADD KEY `fk_dni` (`dni_monitor`),
  ADD KEY `fk_c_s` (`cod_sala`);

--
-- Indices de la tabla `monitor`
--
ALTER TABLE `monitor`
  ADD PRIMARY KEY (`dni_monitor`);

--
-- Indices de la tabla `salones`
--
ALTER TABLE `salones`
  ADD PRIMARY KEY (`cod_sala`);

--
-- Indices de la tabla `socios`
--
ALTER TABLE `socios`
  ADD PRIMARY KEY (`socionro`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `cod_actividad` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `salones`
--
ALTER TABLE `salones`
  MODIFY `cod_sala` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `fk_c_a` FOREIGN KEY (`cod_actividad`) REFERENCES `actividades` (`cod_actividad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_c_s` FOREIGN KEY (`cod_sala`) REFERENCES `salones` (`cod_sala`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dni` FOREIGN KEY (`dni_monitor`) REFERENCES `monitor` (`dni_monitor`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

SELECT COUNT(*) AS veces_pilates
FROM horarios
WHERE cod_actividad = (SELECT cod_actividad FROM actividades WHERE nombre_actividad = 'Pilates');

SELECT COUNT(*) AS clases_pablo_garcia
FROM horarios
WHERE dni_monitor = (SELECT dni_monitor FROM monitor WHERE nombre_monitor = 'Pablo' AND apellido_monitor = 'García');

SELECT DISTINCT m.nombre_monitor, m.apellido_monitor
FROM monitor m
INNER JOIN horarios h ON m.dni_monitor = h.dni_monitor
INNER JOIN actividades a ON h.cod_actividad = a.cod_actividad
WHERE a.nombre_actividad IN ('Yoga', 'Fitness', 'Gimnasia');

SELECT s.nombre_sala, h.fecha, h.hora_inicio, h.hora_fin
FROM horarios h
INNER JOIN salones s ON h.cod_sala = s.cod_sala
WHERE h.fecha IN ('2007-09-09', '2007-09-15');