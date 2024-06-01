-- Active: 1710450499825@@127.0.0.1@3306@videojuego
-- datos ejemplo videojuegos
use videojuego;
 
-- Inserciones de ejemplo en la tabla de Plataformas
INSERT INTO plataformas (id, nombre, descripcion) VALUES
(1, 'PC', 'Plataforma de juegos para ordenadores personales'),
(2, 'PlayStation', 'Consola de videojuegos de Sony'),
(3, 'Xbox', 'Consola de videojuegos de Microsoft');
 
-- Inserciones de ejemplo en la tabla de Desarrolladores
INSERT INTO desarrolladores (id, nombre, descripcion) VALUES
(1, 'Ubisoft', 'Desarrolladora de videojuegos conocida por Assassin''s Creed'),
(2, 'Nintendo', 'Empresa japonesa de videojuegos famosa por Mario'),
(3, 'Rockstar Games', 'Creadores de la serie Grand Theft Auto');
 
-- Inserciones de ejemplo en la tabla de Géneros
INSERT INTO generos (id, nombre) VALUES
(1, 'Acción'),
(2, 'Aventura'),
(3, 'Estrategia');
 
-- Inserciones de ejemplo en la tabla de Fechas
INSERT INTO fechas (id, fecha) VALUES
(1, '2023-01-15'),
(2, '2022-09-30'),
(3, '2024-03-10');
 
-- Inserciones de ejemplo en la tabla de Usuarios
INSERT INTO usuarios (id, nombre_Usuario, correo_Electronico, contrasena) VALUES
(1, 'usuario1', 'usuario1@example.com', 'contraseña1'),
(2, 'jugador2', 'jugador2@example.com', 'password123'),
(3, 'gamer3', 'gamer3@example.com', 'securepass');
 
-- Inserciones de ejemplo en la tabla de Juegos
INSERT INTO videojuegos (id, titulo, id_Plataforma, id_Fecha_lanzamiento, id_Genero, id_Desarrollador, descripcion) VALUES
(1, 'Assassin''s Creed Valhalla', 1, 1, 1, 1, 'Último juego de la saga Assassin''s Creed'),
(2, 'The Legend of Zelda: Breath of the Wild', 2, 2, 2, 2, 'Aventura épica de Link'),
(3, 'Grand Theft Auto V', 3, 3, 1, 3, 'Exitoso juego de mundo abierto de Rockstar Games');
 
-- Inserciones de ejemplo en la tabla de Calificaciones
INSERT INTO calificaciones (id, id_Videojuego, id_Usuario, calificacion) VALUES
(1, 1, 1, 4.5),
(2, 2, 2, 5.0),
(3, 3, 3, 4.8);