-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 09 août 2025 à 22:04
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tasks_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `expires_at`, `created_at`) VALUES
(1, 'test@gmail.com', '4071f3f44cef279426a8a0dd73617edf', '2025-01-20 22:12:07', '2025-01-20 21:12:07'),
(2, 'otm@gmail.com', '2eea29a3062678f7258e2ef7e7051d21', '2025-08-02 12:51:44', '2025-08-02 11:51:44'),
(3, 'otm@gmail.com', 'fae15ae132274acd1581ceac92635b8f', '2025-08-02 12:52:42', '2025-08-02 11:52:42'),
(4, 'otm@gmail.com', '02651e43a08a6200bb30fb8d5b688a85', '2025-08-02 12:53:58', '2025-08-02 11:53:58'),
(13, 'o67691349@gmail.com', 'a494b426917d291ddedd374599b0fb30', '2025-08-02 18:52:28', '2025-08-02 17:52:28'),
(12, 'o67691349@gmail.com', '421c34ec33b09a1f0efb8125687c602d', '2025-08-02 19:52:20', '2025-08-02 17:52:20'),
(11, 'o67691349@gmail.com', 'f0073e5f3318f74c9df4ae348a16c4b34f77d69540d42bd264c998950b871571', '2025-08-02 18:26:01', '2025-08-02 17:26:01'),
(10, 'o67691349@gmail.com', 'ebc0829e20a7c00b8bd13d8c556e6bf5', '2025-08-02 18:04:22', '2025-08-02 17:04:22');

-- --------------------------------------------------------

--
-- Structure de la table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `task_name` varchar(255) NOT NULL,
  `is_completed` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `tasks`
--

INSERT INTO `tasks` (`id`, `user_id`, `task_name`, `is_completed`, `created_at`) VALUES
(1, 1, 'test', 0, '2025-01-20 21:03:26'),
(2, 1, 'test', 0, '2025-01-20 21:03:28'),
(3, 1, 'test', 0, '2025-01-22 09:41:16'),
(4, 2, 'PFE', 0, '2025-01-22 09:42:23'),
(5, 2, 'PHP', 0, '2025-01-22 09:46:05'),
(6, 3, 'PFE', 0, '2025-01-24 19:49:32'),
(14, 4, 'send email', 0, '2025-08-09 08:38:05'),
(10, 5, 'chorok', 0, '2025-08-02 11:58:16'),
(13, 4, 'github', 1, '2025-08-09 08:37:27');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(1, 'test@gmail.com', '$2y$10$He2mcTXuSFV2r0EnpXeQluFf/c3YS0YpFnY28/CgJilkGoOIhJeuO', '2025-01-20 21:02:39'),
(2, 'ayoub@gmail.com', '$2y$10$8Ng/wy.Ob9tureAqtSDpqujUqnriEljP9Xqlr583tL7nck5isGqkG', '2025-01-22 09:42:03'),
(3, 'gm@gmail.com', '$2y$10$Lqo.yhh7dObughZgjlsCuuDRVaIim7P90X.dNuDQiMUT.NyM/JKJe', '2025-01-24 19:48:58'),
(4, 'otm@gmail.com', '$2y$10$rHqWSu68ibR4o.wDcqO1Tu24ZyZQjvYvN.sYIz4i0OM3u/pI2VSnO', '2025-07-16 23:01:13'),
(5, 'o67691349@gmail.com', '$2y$10$iMs41Byb.OVB.xReRV4vmuR4dKR70U.8Yp1yN8pRyj0x5PyX9INPW', '2025-08-02 11:57:59');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
