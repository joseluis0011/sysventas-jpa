-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-06-2018 a las 06:18:01
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_ventas1`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarPersona` (IN `cod` CHAR(8))  BEGIN
select p.nombres, p.apellidos, u.clave from persona p, usuario u WHERE p.idpersona = cod and u.idpersona = p.idpersona;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarProductoCodigo` (IN `cod` INT(11))  BEGIN
SELECT *FROM producto WHERE codigo = cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUser` (IN `cad` VARCHAR(45))  BEGIN
SELECT * FROM usuario WHERE nom_user LIKE CONCAT(cad,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createPersona` (IN `nombre` VARCHAR(45), IN `apel` VARCHAR(45), IN `dni` CHAR(8), IN `tel` CHAR(9))  BEGIN
INSERT INTO persona (idpersona, nombres, apellidos, dni, telefono) VALUE(null, nombre, apel, dni, tel);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createProducto` (IN `npro` VARCHAR(45), IN `prec` DOUBLE, IN `stck` INT(10))  BEGIN
INSERT INTO producto (idproducto, nom_prod, precio, stock) VALUE(null, npro, prec, stck);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createRol` (IN `nrol` VARCHAR(45))  BEGIN
INSERT INTO rol (idrol, nom_rol) VALUES(null, nrol);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editarProducto` (IN `idproduit` INT, IN `nom_produit` VARCHAR(20), IN `prepro` DOUBLE, IN `stopro` INT(4))  BEGIN
UPDATE producto SET nom_prod=nom_produit, precio=prepro, stock= stopro WHERE idproducto = idproduit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editarRol` (IN `idr` INT, IN `nomrol` VARCHAR(45))  BEGIN
UPDATE rol SET nom_rol=nomrol WHERE idrol = idr;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDetalleVenta` (IN `idd` INT(11))  BEGIN
DELETE FROM detalle_venta WHERE iddetalle_venta = idd;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarProducto` (IN `idproduit` INT)  BEGIN
DELETE FROM producto WHERE idproducto = idproduit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarRol` (IN `idr` INT)  BEGIN
DELETE FROM rol WHERE idrol = idr;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarVenta` (IN `idv` INT(11))  BEGIN
DELETE FROM ventas WHERE idventas = idv;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetalle` (IN `idv` INT(11), IN `idp` INT(11), IN `precio` DOUBLE, IN `cant` INT(11))  BEGIN
INSERT INTO detalle_venta(iddetalle_venta, idventas, idproducto, precio, cantidad) VALUES(null, idv, idp, precio, cant);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarVenta` (IN `idp` INT(11), IN `idc` INT(11), OUT `idv` INT(11))  BEGIN
INSERT INTO ventas (idventas, fecha, idpersona, idcliente) VALUES(null, now(), idp, idc);
SELECT DISTINCT LAST_INSERT_ID() INTO idv FROM ventas;
SELECT idv;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarCliente` (IN `cod` CHAR(8))  BEGIN
 SELECT *FROM persona WHERE dni=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarDetalle` ()  BEGIN
SELECT d.iddetalle_venta, p.nom_prod, d.precio, d.cantidad
FROM detalle_venta d, producto p
WHERE d.idproducto = p.idproducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarPersona` ()  BEGIN

SELECT *FROM persona;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarPersona2` (IN `cod` CHAR(8))  BEGIN
SELECT *FROM persona WHERE dni=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProducto` ()  BEGIN
SELECT * FROM producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarRol` ()  BEGIN
SELECT *FROM rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarUsuario` ()  BEGIN
SELECT u.idusuario, p.nombres, p.apellidos, u.nom_user, r.nom_rol FROM usuario as u, rol as r, persona as p
where
u.idrol = r.idrol
and
u.idpersona = p.idpersona
and
u.estado<>0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `searchId` (IN `id` INT)  BEGIN
SELECT *FROM rol WHERE idrol = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `searchRol` (IN `nomrol` TEXT)  BEGIN
SELECT *FROM rol WHERE nom_rol = nomrol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePersona` (IN `idper` INT, IN `nom` VARCHAR(50), IN `ape` VARCHAR(50), IN `cla` VARCHAR(50))  BEGIN
UPDATE persona p, usuario u SET p.nombres=nom, p.apellidos=ape, u.clave = cla WHERE p.idpersona = idper AND u.idpersona = p.idpersona;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validarUser` (IN `nomuser` VARCHAR(15), IN `pass` VARCHAR(15))  BEGIN
SELECT p.nombres, p.apellidos, u.idusuario, u.nom_user, r.nom_rol, p.idpersona FROM usuario as u, rol as r, persona p where p.idpersona= u.idpersona and u.idrol = r.idrol and nom_user = nomuser and clave = pass and estado = '1';
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventas` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `precio` double DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventas`, `idproducto`, `precio`, `cantidad`) VALUES
(1, 4, 1, 2000, 2),
(2, 17, 1, 2000, 3),
(3, 37, 1, 2500, 1),
(4, 37, 3, 100, 1),
(5, 38, 1, 2500, 1),
(6, 38, 2, 1000, 3),
(7, 38, 3, 100, 4),
(8, 39, 1, 2500, 1),
(9, 39, 2, 1000, 1),
(10, 39, 3, 100, 1),
(11, 40, 1, 2500, 3),
(12, 40, 2, 1000, 2),
(13, 41, 1, 2500, 1),
(14, 41, 2, 1000, 1),
(15, 42, 1, 2500, 1),
(16, 43, 1, 2500, 1),
(17, 44, 1, 2500, 1),
(18, 45, 1, 2500, 1),
(19, 46, 1, 2500, 1),
(20, 47, 1, 2500, 1),
(21, 48, 1, 2500, 1),
(22, 49, 1, 2500, 1),
(23, 49, 3, 100, 1),
(28, 54, 1, 2500, 4),
(39, 54, 1, 2500, 1),
(40, 54, 1, 2500, 1),
(41, 57, 1, 2500, 1),
(42, 58, 1, 2500, 1),
(43, 59, 1, 2500, 2),
(44, 60, 1, 2500, 6),
(45, 61, 1, 2500, 7),
(46, 62, 2, 1000, 1),
(47, 63, 3, 100, 3),
(48, 64, 3, 100, 1),
(49, 64, 2, 1000, 1),
(50, 65, 3, 100, 1),
(51, 65, 2, 1000, 1),
(52, 66, 1, 2500, 2),
(53, 66, 2, 1000, 1),
(54, 67, 1, 2500, 1);

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `insertarDetalle` AFTER INSERT ON `detalle_venta` FOR EACH ROW UPDATE producto SET stock = stock - NEW.cantidad WHERE idproducto= NEW.idproducto
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `nombres` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `dni` char(8) DEFAULT NULL,
  `telefono` char(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `nombres`, `apellidos`, `dni`, `telefono`) VALUES
(1, 'Jose', 'Ramos', '20000112', '2012'),
(2, 'Emily', 'Ccana', '12345678', '6789'),
(3, 'Eliseo', 'Reyes', '87654321', '567890900'),
(4, 'Claribel', 'Perez', '23232323', '34343'),
(5, 'jonas', 'Ganoza', '47474747', '523562');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL,
  `nom_prod` varchar(45) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `codigo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idproducto`, `nom_prod`, `precio`, `stock`, `codigo`) VALUES
(1, 'Laptop', 2500, 17, 101),
(2, 'Pantalla Dell', 1000, 19, 102),
(3, 'Parlantes', 100, 0, 103);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idrol` int(11) NOT NULL,
  `nom_rol` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `nom_rol`) VALUES
(1, 'Administrador'),
(2, 'Gerente de Ventas'),
(3, 'Vendedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nom_user` varchar(15) DEFAULT NULL,
  `clave` varchar(15) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL,
  `idrol` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nom_user`, `clave`, `estado`, `idrol`, `idpersona`) VALUES
(1, 'emilyc', '123', '1', 1, 2),
(2, 'joser', '123459', '1', 3, 1),
(3, 'aa', '123', '1', 2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idventas` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `idpersona` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idventas`, `fecha`, `idpersona`, `idcliente`) VALUES
(1, '2018-05-22 00:00:00', 2, 2),
(4, '2018-05-22 20:25:10', 2, 2),
(17, '2018-05-24 13:58:47', 2, 5),
(37, '2018-05-28 19:22:46', 2, 5),
(38, '2018-05-28 19:24:47', 2, 5),
(39, '2018-05-29 08:39:59', 2, 5),
(40, '2018-05-29 08:58:33', 2, 5),
(41, '2018-05-29 14:21:15', 2, 5),
(42, '2018-05-29 14:26:04', 2, 5),
(43, '2018-05-29 14:27:16', 2, 5),
(44, '2018-05-29 14:31:29', 2, 5),
(45, '2018-05-29 14:32:40', 2, 5),
(46, '2018-05-29 14:33:34', 2, 5),
(47, '2018-05-29 14:37:22', 2, 5),
(48, '2018-05-29 14:38:38', 2, 5),
(49, '2018-05-30 08:37:11', 2, 5),
(50, '2018-05-30 09:52:30', 2, 5),
(51, '2018-05-30 10:06:26', 2, 5),
(52, '2018-05-30 10:07:42', 2, 5),
(53, '2018-05-30 10:10:22', 2, 5),
(54, '2018-05-30 10:11:09', 2, 5),
(55, '2018-05-30 10:15:30', 2, 5),
(56, '2018-05-30 10:16:44', 2, 5),
(57, '2018-05-30 11:12:44', 2, 5),
(58, '2018-05-30 20:49:24', 2, 5),
(59, '2018-05-30 20:50:37', 2, 5),
(60, '2018-05-30 20:51:03', 2, 5),
(61, '2018-05-30 20:51:33', 2, 5),
(62, '2018-05-30 20:53:07', 2, 5),
(63, '2018-05-30 20:55:00', 2, 5),
(64, '2018-05-30 20:58:15', 2, 5),
(65, '2018-05-30 21:01:26', 2, 5),
(66, '2018-05-31 09:25:38', 2, 5),
(67, '2018-05-31 17:26:41', 2, 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_ventas1_idx` (`idventas`),
  ADD KEY `fk_detalle_venta_producto1_idx` (`idproducto`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idproducto`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD KEY `fk_usuario_rol_idx` (`idrol`),
  ADD KEY `fk_usuario_persona1_idx` (`idpersona`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idventas`),
  ADD KEY `fk_pedidos_persona1_idx` (`idpersona`),
  ADD KEY `fk_ventas_persona1_idx` (`idcliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;
--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idrol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_producto1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_venta_ventas1` FOREIGN KEY (`idventas`) REFERENCES `ventas` (`idventas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_persona1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_pedidos_persona1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ventas_persona1` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
