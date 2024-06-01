CREATE DATABASE videojuego; 
USE videojuego;

-- Tabla de Plataformas
-- id como BIGINT porque se maneja como Long en Java
CREATE TABLE IF NOT EXISTS plataformas (
  id BIGINT PRIMARY KEY auto_increment, 
  nombre VARCHAR(50) NOT NULL,
  descripcion TEXT
);
 
-- Tabla de Desarrolladores
CREATE TABLE IF NOT EXISTS desarrolladores (
  id BIGINT PRIMARY KEY auto_increment,
  nombre VARCHAR(50) NOT NULL,
  descripcion TEXT
);
 
-- Tabla de Géneros
CREATE TABLE IF NOT EXISTS generos (
  id BIGINT PRIMARY KEY auto_increment,
  nombre VARCHAR(50) NOT NULL
);
 
-- Tabla de Fechas
CREATE TABLE IF NOT EXISTS fechas (
  id BIGINT PRIMARY KEY auto_increment,
  fecha DATE NOT NULL
);
 
-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS usuarios (
  id BIGINT PRIMARY KEY auto_increment,
  nombre_Usuario VARCHAR(50) NOT NULL,
  correo_Electronico VARCHAR(100) NOT NULL,
  contrasena VARCHAR(100) NOT NULL
);
 
-- Tabla de Videojuegos
CREATE TABLE IF NOT EXISTS videojuegos (
  id BIGINT PRIMARY KEY auto_increment,
  titulo VARCHAR(100) NOT NULL,
  id_Plataforma BIGINT NOT NULL,
  id_Fecha_Lanzamiento BIGINT NOT NULL,
  id_Genero BIGINT NOT NULL,
  id_Desarrollador BIGINT NOT NULL,
  descripcion TEXT,
  FOREIGN KEY (id_Plataforma) REFERENCES plataformas(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_Fecha_Lanzamiento) REFERENCES fechas(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_Genero) REFERENCES generos(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_Desarrollador) REFERENCES desarrolladores(id) ON UPDATE CASCADE ON DELETE CASCADE
);
 
-- Tabla de Calificaciones
CREATE TABLE IF NOT EXISTS calificaciones (
  id BIGINT PRIMARY KEY auto_increment,
  id_Videojuego BIGINT NOT NULL,
  id_Usuario BIGINT NOT NULL,
  calificacion DECIMAL(2,1) NOT NULL,
  FOREIGN KEY (id_Videojuego) REFERENCES videojuegos(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_Usuario) REFERENCES usuarios(id) ON UPDATE CASCADE ON DELETE CASCADE
);
