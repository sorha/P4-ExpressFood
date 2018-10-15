-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 10 oct. 2018 à 02:10
-- Version du serveur :  5.7.19
-- Version de PHP :  5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `expressfood`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `adresse_id` int(11) NOT NULL AUTO_INCREMENT,
  `ville` varchar(100) NOT NULL,
  `rue` varchar(100) NOT NULL,
  `numero` int(11) NOT NULL,
  `code_postal` varchar(20) NOT NULL,
  `etage` smallint(4) DEFAULT NULL,
  `batiment` varchar(50) DEFAULT NULL,
  `digicode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`adresse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`adresse_id`, `ville`, `rue`, `numero`, `code_postal`, `etage`, `batiment`, `digicode`) VALUES
(1, 'Lille', 'Rue du Monopoly', 6, '59000', NULL, NULL, NULL),
(2, 'Nancy', 'place Stanislas', 36, '54100', NULL, NULL, NULL),
(3, 'Gap', 'rue Saint Germain', 41, '0500', NULL, NULL, NULL),
(4, 'Rennes', 'rue Lenotre', 95, '3500', 2, 'B', '4517'),
(5, 'Etampes', 'rue du Palais', 79, '91150', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `password` binary(60) NOT NULL,
  `adresse_facturation_id` int(11) NOT NULL,
  `adresse_livraison_id` int(11) NOT NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE KEY `email` (`email`),
  KEY `adresse_id` (`adresse_facturation_id`),
  KEY `adresse_livraison_id` (`adresse_livraison_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`client_id`, `nom`, `prenom`, `email`, `telephone`, `password`, `adresse_facturation_id`, `adresse_livraison_id`) VALUES
(1, 'Depraetere', 'Alexandre', 'depraetere.alexandre@gmail.com', '0471202592', 0x2432792431302432796e506377572f4943545950786b78632f6e4836656c567744776d4937656c4e4d434459773148385635586f5949666c786b7543, 1, 1),
(2, 'Noel', 'Stéphanie', 'stéphanie.noel@gmail.com', '0159324030', 0x2432792431302432796e506377572f4943545950786b78632f6e4836656c567744776d4937656c4e4d434459773148385635586f5949666c786b7543, 2, 2),
(3, 'Fluet', 'Renée', 'renee.fluet@gmail.com', '0233687820', 0x2432792431302432796e506377572f4943545950786b78632f6e4836656c567744776d4937656c4e4d434459773148385635586f5949666c786b7543, 3, 3),
(4, 'Dufresne', 'Denis', 'dufresne.denis@gmail.com', ' 0289103513', 0x2432792431302432796e506377572f4943545950786b78632f6e4836656c567744776d4937656c4e4d434459773148385635586f5949666c786b7543, 4, 4),
(5, 'Valiant', 'Bernard', 'valiant.bernard', ' 0164667107', 0x2432792431302432796e506377572f4943545950786b78632f6e4836656c567744776d4937656c4e4d434459773148385635586f5949666c786b7543, 5, 5);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `commande_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `livreur_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `commande_statut` tinyint(1) NOT NULL,
  `date_livraison` datetime NOT NULL,
  `paiement` tinyint(1) NOT NULL,
  PRIMARY KEY (`commande_id`),
  KEY `client_id` (`client_id`),
  KEY `livreur_id` (`livreur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`commande_id`, `client_id`, `livreur_id`, `date`, `commande_statut`, `date_livraison`, `paiement`) VALUES
(1, 1, 2, '2018-10-02 08:25:15', 1, '2018-10-02 09:30:00', 1),
(2, 3, 2, '2018-10-07 00:00:00', 1, '2018-10-07 16:00:00', 1),
(3, 3, NULL, '2018-10-09 09:11:28', 2, '2018-10-12 09:30:00', 0);

-- --------------------------------------------------------

--
-- Structure de la table `ligne_commande`
--

DROP TABLE IF EXISTS `ligne_commande`;
CREATE TABLE IF NOT EXISTS `ligne_commande` (
  `commande_id` int(11) NOT NULL,
  `plat_id` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  PRIMARY KEY (`commande_id`,`plat_id`),
  KEY `plat_id` (`plat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `ligne_commande`
--

INSERT INTO `ligne_commande` (`commande_id`, `plat_id`, `quantite`) VALUES
(1, 1, 2),
(1, 3, 2),
(2, 1, 4),
(2, 4, 2),
(3, 3, 2);

-- --------------------------------------------------------

--
-- Structure de la table `livreur`
--

DROP TABLE IF EXISTS `livreur`;
CREATE TABLE IF NOT EXISTS `livreur` (
  `livreur_id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `statut_livreur` tinyint(1) NOT NULL,
  `longitude` varchar(30) NOT NULL,
  `latitude` varchar(30) NOT NULL,
  PRIMARY KEY (`livreur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `livreur`
--

INSERT INTO `livreur` (`livreur_id`, `nom`, `prenom`, `telephone`, `statut_livreur`, `longitude`, `latitude`) VALUES
(1, 'Bazin', 'Didiane', '0221776563', 1, '50.629756', '3.049220'),
(2, 'Lévesque', 'Roxanne', ' 0110060818', 1, '48.691553', '6.176741');

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

DROP TABLE IF EXISTS `plat`;
CREATE TABLE IF NOT EXISTS `plat` (
  `plat_id` int(11) NOT NULL AUTO_INCREMENT,
  `plat_nom` varchar(100) NOT NULL,
  `prix_unitaire` decimal(6,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `type_plat` tinyint(2) NOT NULL,
  PRIMARY KEY (`plat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`plat_id`, `plat_nom`, `prix_unitaire`, `stock`, `type_plat`) VALUES
(1, 'Boeuf bourguignon', '10.89', 15, 1),
(2, 'Choucroute garnie', '11.20', 12, 1),
(3, 'Crème brûlée', '8.34', 14, 2),
(4, 'Riz au lait', '7.99', 9, 2);

-- --------------------------------------------------------

--
-- Structure de la table `plat_du_jour`
--

DROP TABLE IF EXISTS `plat_du_jour`;
CREATE TABLE IF NOT EXISTS `plat_du_jour` (
  `plat_du_jour_id` int(11) NOT NULL AUTO_INCREMENT,
  `plat_id` int(11) NOT NULL,
  `date_menu` date NOT NULL,
  PRIMARY KEY (`plat_du_jour_id`),
  KEY `plat_id` (`plat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat_du_jour`
--

INSERT INTO `plat_du_jour` (`plat_du_jour_id`, `plat_id`, `date_menu`) VALUES
(1, 1, '2018-10-02'),
(2, 2, '2018-10-02'),
(3, 3, '2018-10-02'),
(4, 4, '2018-10-02');

-- --------------------------------------------------------

--
-- Structure de la table `stock_livreur`
--

DROP TABLE IF EXISTS `stock_livreur`;
CREATE TABLE IF NOT EXISTS `stock_livreur` (
  `livreur_id` int(11) NOT NULL,
  `plat_id` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  PRIMARY KEY (`livreur_id`,`plat_id`),
  KEY `plat_id` (`plat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `stock_livreur`
--

INSERT INTO `stock_livreur` (`livreur_id`, `plat_id`, `quantite`) VALUES
(1, 1, 4),
(1, 2, 2),
(1, 3, 5),
(2, 4, 4);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`adresse_facturation_id`) REFERENCES `adresse` (`adresse_id`),
  ADD CONSTRAINT `client_ibfk_2` FOREIGN KEY (`adresse_livraison_id`) REFERENCES `adresse` (`adresse_id`);

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `commande_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  ADD CONSTRAINT `commande_ibfk_2` FOREIGN KEY (`livreur_id`) REFERENCES `livreur` (`livreur_id`);

--
-- Contraintes pour la table `ligne_commande`
--
ALTER TABLE `ligne_commande`
  ADD CONSTRAINT `ligne_commande_ibfk_1` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`commande_id`),
  ADD CONSTRAINT `ligne_commande_ibfk_2` FOREIGN KEY (`plat_id`) REFERENCES `plat` (`plat_id`);

--
-- Contraintes pour la table `plat_du_jour`
--
ALTER TABLE `plat_du_jour`
  ADD CONSTRAINT `plat_du_jour_ibfk_1` FOREIGN KEY (`plat_id`) REFERENCES `plat` (`plat_id`);

--
-- Contraintes pour la table `stock_livreur`
--
ALTER TABLE `stock_livreur`
  ADD CONSTRAINT `stock_livreur_ibfk_1` FOREIGN KEY (`livreur_id`) REFERENCES `livreur` (`livreur_id`),
  ADD CONSTRAINT `stock_livreur_ibfk_2` FOREIGN KEY (`plat_id`) REFERENCES `plat` (`plat_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
