-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-02-2020 a las 19:39:53
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.3.1

SET FOREIGN_KEY_CHECKS=0;

--
-- Base de datos: `extreme_samp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accounts`
--
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `SQL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(24) DEFAULT '<usuario>',
  `IP` varchar(18) DEFAULT '0.0.0.0',
  `CREATED` int(2) DEFAULT '0',
  `PASSWORD` varchar(129) DEFAULT NULL,
  `SECURITY_QUESTION` varchar(128) DEFAULT '0',
  `SECURITY_ANSWER` varchar(64) DEFAULT '0',
  `EMAIL` varchar(64) DEFAULT '<nombre@dominio.tipo>',
  `REGISTER_TIMESTAMP` varchar(36) DEFAULT '0',
  `LASTLOGIN_TIMESTAMP` varchar(36) DEFAULT '0',
  `SCORE` int(11) DEFAULT '0',
  `EXPERIENCE` int(11) DEFAULT '0',
  `PLAYING_MINUTES` int(11) DEFAULT '0',
  `PLAYING_HOURS` int(11) DEFAULT '0',
  `MONEY` int(11) DEFAULT '0',
  `BANK_MONEY` int(11) DEFAULT '0',
  `SKIN` int(11) DEFAULT '0',
  `GENDER` int(2) DEFAULT '0',
  `BIRTHDATE` varchar(32) DEFAULT '01/01/1970',
  `ADMIN_LEVEL` int(2) DEFAULT '0',
  `ADMIN_DUTY_TIME` int(11) DEFAULT '0',
  `VIP_LEVEL` int(2) DEFAULT '0',
  `POSITION_X` float DEFAULT '0',
  `POSITION_Y` float DEFAULT '0',
  `POSITION_Z` float DEFAULT '0',
  `POSITION_ANGLE` float DEFAULT '0',
  `HEALTH` float DEFAULT '0',
  `ARMOUR` float DEFAULT '0',
  `WORLD` int(11) DEFAULT '0',
  `INTERIOR` int(11) DEFAULT '0',
  `ENTRANCE` int(11) DEFAULT '-1',
  `HOUSE` int(11) DEFAULT '-1',
  `BUSINESSES` int(11) DEFAULT '-1',
  `INJURED` int(2) DEFAULT '0',
  `KILLED` int(2) DEFAULT '0',
  `FACTION` int(11) DEFAULT '-1',
  `FACTION_ID` int(11) DEFAULT '-1',
  `FACTION_RANK` int(11) DEFAULT '-1',
  `DESCRIPTION` varchar(64) DEFAULT '<estado>',
  `TEACHER_LEVEL` int(2) DEFAULT '0',
  `TEACHER_DUTY_TIME` int(11) DEFAULT '0',
  `TEACHER_NAME` varchar(24) DEFAULT '<nombre_apellido>',
  `TEACHER_CLASS` int(2) DEFAULT '0',
  `GLOBAL_DISABLE` int(2) DEFAULT '0',
  `FACTION_DISABLE` int(2) DEFAULT '0',
  `BUSINESSES_DISABLE` int(2) DEFAULT '0',
  `SPEEDO_DISABLE` int(2) DEFAULT '0',
  `MONEY_DRAW_DISABLE` int(2) DEFAULT '0',
  `SERVER_DRAW_DISABLE` int(2) DEFAULT '0',
  `ANIMATION_DISABLE` int(2) DEFAULT '0',
  PRIMARY KEY (`SQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Estructura de tabla para la tabla `entrances`
--
DROP TABLE IF EXISTS `entrances`;
CREATE TABLE `entrances` (
  `entranceID` int(12) NOT NULL AUTO_INCREMENT,
  `entranceNAME` varchar(32) DEFAULT NULL,
  `entranceICON` int(12) DEFAULT '0',
  `entrancePOSITION_X` float DEFAULT '0',
  `entrancePOSITION_Y` float DEFAULT '0',
  `entrancePOSITION_Z` float DEFAULT '0',
  `entrancePOSITION_A` float DEFAULT '0',
  `entranceINT_X` float DEFAULT '0',
  `entranceINT_Y` float DEFAULT '0',
  `entranceINT_Z` float DEFAULT '0',
  `entranceINT_A` float DEFAULT '0',
  `entranceINTERIOR` int(12) DEFAULT '0',
  `entranceEXTERIOR` int(12) DEFAULT '0',
  `entranceEXTERIOR_VW` int(12) DEFAULT '0',
  `entranceTYPE` int(12) DEFAULT '0',
  `entrancePASS` varchar(32) DEFAULT NULL,
  `entranceLOCKED` int(12) DEFAULT '0',
  `entranceWORLD` int(12) DEFAULT '0',
  PRIMARY KEY (`entranceID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Estructura de tabla para la tabla `cars`
--
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `carSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `carMODEL` int(12) DEFAULT '0',
  `carOWNER` int(12) DEFAULT '0',
  `carOWNER_NAME` varchar(24) DEFAULT '<nombre_apellido>',
  `carPOSITION_X` float DEFAULT '0',
  `carPOSITION_Y` float DEFAULT '0',
  `carPOSITION_Z` float DEFAULT '0',
  `carPOSITION_ANGLE` float DEFAULT '0',
  `carCOLOR_1` int(12) DEFAULT '-1',
  `carCOLOR_2` int(12) DEFAULT '-1',
  `carPAINT_JOB` int(12) DEFAULT '-1',
  `carLOCKED` int(4) DEFAULT '0',
  `carMOD_1` int(12) DEFAULT '0',
  `carMOD_2` int(12) DEFAULT '0',
  `carMOD_3` int(12) DEFAULT '0',
  `carMOD_4` int(12) DEFAULT '0',
  `carMOD_5` int(12) DEFAULT '0',
  `carMOD_6` int(12) DEFAULT '0',
  `carMOD_7` int(12) DEFAULT '0',
  `carMOD_8` int(12) DEFAULT '0',
  `carMOD_9` int(12) DEFAULT '0',
  `carMOD_10` int(12) DEFAULT '0',
  `carMOD_11` int(12) DEFAULT '0',
  `carMOD_12` int(12) DEFAULT '0',
  `carMOD_13` int(12) DEFAULT '0',
  `carMOD_14` int(12) DEFAULT '0',
  `carGAS` int(12) DEFAULT '25',
  `carKMS` int(12) DEFAULT '0',
  `carMETERS` int(12) DEFAULT '0',
  `carVALUE` int(64) DEFAULT '0',
  `carPLATE` varchar(13) DEFAULT '<gt0000a>',
  `carMECHANICAL_INSIDE` int(12) DEFAULT '-1',
  `carWORLD` int(8) DEFAULT '0',
  `carINTERIOR` int(8) DEFAULT '0',
  `carTIME_FADING` int(12) DEFAULT '0',
  `carCALL_SIGN` int(12) DEFAULT '0',
  `carCALL_SIGN_NAME` varchar(24) DEFAULT '<callsign>',
  `carASIGN` int(12) DEFAULT '-1',
  `carASIGN_NAME` varchar(24) DEFAULT '<nombre_apellido>',
  `carTAKEN` int(12) DEFAULT '-1',
  `carTAKEN_NAME` varchar(24) DEFAULT '<nombre_apellido>',
  `carIMPOUNDED` int(12) DEFAULT '0',
  `carIMPOUND_PRICE` int(12) DEFAULT '0',
  `carFACTION` int(12) DEFAULT '-1',
  `carJOB` int(12) DEFAULT '-1',
  `carDMV` int(12) DEFAULT '0',
  `carBIZ` int(12) DEFAULT '-1',
  `carRENT` int(12) DEFAULT '0',
  `carRENT_PRICE` int(12) DEFAULT '0',
  `carSALE` int(12) DEFAULT '0',
  `carSALE_PRICE` int(12) DEFAULT '0',
  `carSTEREO` int(12) DEFAULT '1',
  `carPANELS` int(8) DEFAULT '0',
  `carDOORS` int(8) DEFAULT '0',
  `carLIGHTS` int(8) DEFAULT '0',
  `carTIRES` int(8) DEFAULT '0',
  `carDAMAGE` float DEFAULT '1000.0',
  `carLIGHTS_STATUS` int(12) DEFAULT '0',
  `carSTATION_URL` varchar(128) DEFAULT '<url>',
  `carGLOVE_BOX` int(12) DEFAULT '0',
  `carGLOVE_BOX_QUANTITY` int(12) DEFAULT '0',
  `carTRUNK_1` int(5) DEFAULT '0',
  `carTRUNK_2` int(5) DEFAULT '0',
  `carTRUNK_3` int(5) DEFAULT '0',
  `carTRUNK_4` int(5) DEFAULT '0',
  `carTRUNK_5` int(5) DEFAULT '0',
  `carTRUNK_6` int(5) DEFAULT '0',
  `carTRUNK_7` int(5) DEFAULT '0',
  `carTRUNK_8` int(5) DEFAULT '0',
  `carTRUNK_9` int(5) DEFAULT '0',
  `carTRUNK_10` int(5) DEFAULT '0',
  `carTRUNK_QUANTITY_1` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_2` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_3` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_4` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_5` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_6` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_7` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_8` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_9` int(10) DEFAULT '0',
  `carTRUNK_QUANTITY_10` int(10) DEFAULT '0',
  `carCEPO` int(12) DEFAULT '0',
  `carLAST_USER` varchar(24) DEFAULT '<nombre_apellido>',
  PRIMARY KEY (`carSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Estructura de tabla para la tabla `cars`
--
DROP TABLE IF EXISTS `logs_staff`;
CREATE TABLE `logs_staff` (
  `logSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `logCONTENT` varchar(128) DEFAULT '<contenido>',
  PRIMARY KEY (`logSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `logs_money`;
CREATE TABLE `logs_money` (
  `logSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `logCONTENT` varchar(128) DEFAULT '<contenido>',
  PRIMARY KEY (`logSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `logs_bank`;
CREATE TABLE `logs_bank` (
  `logSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `logCONTENT` varchar(128) DEFAULT '<contenido>',
  PRIMARY KEY (`logSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `logs_properties`;
CREATE TABLE `logs_properties` (
  `logSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `logCONTENT` varchar(128) DEFAULT '<contenido>',
  PRIMARY KEY (`logSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `logs_joins`;
CREATE TABLE `logs_joins` (
  `logSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `logCONTENT` varchar(128) DEFAULT '<contenido>',
  PRIMARY KEY (`logSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `logs_cheats`;
CREATE TABLE `logs_cheats` (
  `logSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `logCONTENT` varchar(128) DEFAULT '<contenido>',
  PRIMARY KEY (`logSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `log_blocks`;
CREATE TABLE `log_blocks` (
  `logSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `logCONTENT` varchar(128) DEFAULT '<contenido>',
  PRIMARY KEY (`logSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `logs_general`;
CREATE TABLE `logs_general` (
  `logSQL_ID` int(12) NOT NULL AUTO_INCREMENT,
  `logCONTENT` varchar(128) DEFAULT '<contenido>',
  PRIMARY KEY (`logSQL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

SET FOREIGN_KEY_CHECKS=1;
