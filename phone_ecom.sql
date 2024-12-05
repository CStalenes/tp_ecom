DROP DATABASE IF EXISTS phone_ecom;
CREATE DATABASE phone_ecom;
USE phone_ecom;



CREATE TABLE User(
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    mdp VARCHAR(50),
    role_user ENUM('admin','user') NOT NULL
);


CREATE TABLE Client (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nom VARCHAR(50) NOT NULL,
	prenom VARCHAR(50) NOT NULL,
	adresse VARCHAR(100) NOT NULL,
    ville VARCHAR(50),
    code_postal VARCHAR(10),
    pays VARCHAR(50) NOT NULL
);

CREATE TABLE Categorie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(50),
    description_categorie VARCHAR(100) 

);

CREATE TABLE Article (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_article VARCHAR(50) NOT NULL,
    designation VARCHAR(100) ,
    prix DECIMAL(10, 2) NOT NULL,
    quantite_stock INT,
    id_categorie INT,
    FOREIGN KEY (id_categorie) REFERENCES Categorie(id)
);

CREATE TABLE Commande (
	id INT AUTO_INCREMENT PRIMARY KEY,
    montant_total DECIMAL(10, 2) NOT NULL,
    statut ENUM('en traitement', 'expédiée', 'livrée', 'annulée') DEFAULT 'en traitement',
	date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	date_livraison DATE,
	id_client INT,
	FOREIGN KEY (id_client) REFERENCES Client(id)
);


CREATE TABLE Panier(
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_client INT,
    FOREIGN KEY (id_client) REFERENCES Client(id)

);

CREATE TABLE Paiement(
    id INT AUTO_INCREMENT PRIMARY KEY,
    montant DECIMAL(10, 2) NOT NULL,
    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    mode_paiement ENUM('carte bancaire', 'PayPal', 'virement') NOT NULL,
    statut ENUM('réussi','echoué','en attente') DEFAULT 'en attente',
    id_commande INT,
    FOREIGN KEY (id_commande) REFERENCES Commande(id)

);

CREATE TABLE Contenir(
    id_contenir INT AUTO_INCREMENT PRIMARY KEY,
    id_commande INT,
    id_article INT,
    quantite INT,
    prix_unitaire DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_commande) REFERENCES Commande(id),
    FOREIGN KEY (id_article) REFERENCES Article(id)
);

CREATE TABLE Ajouter(
    id_ajouter INT AUTO_INCREMENT PRIMARY KEY,
    id_article INT,
    id_panier INT,
    prix_article  DECIMAL(10, 2) NOT NULL,
    quantite_article INT,
    FOREIGN KEY (id_article) REFERENCES Article(id),
    FOREIGN KEY (id_panier)  REFERENCES Panier(id)

);


-- INSERTION DATA

-- Insertion d'un user
INSERT INTO User(email, mdp, role_user)
VALUES
('jean.dupont@gmail.com', 'acid123','user'),
('lea.doumbe@yahoo.fr', 'mera456','user');

-- Insertion d'un client
INSERT INTO Client (nom, prenom, adresse, ville, code_postal, pays) 
VALUES
('Dupont', 'Jean', '12 rue de la République', 'Paris', '75001', 'France'),
('Doumbe', 'Lea', '45 avenue Champsigny', 'Paris', '93100', 'France')
('Beaugard','Stanlone', '39 avenue Gambetta 75120', 'France');

-- Insérer des catégories dans la table Categorie
INSERT INTO Categorie (nom_categorie, description_categorie)
VALUES 
('Smartphones', 'Téléphones portables de différentes marques et modèles'),
('Accessoires', 'Accessoires pour téléphones mobiles'),
('Tablettes', 'Tablettes tactiles de différentes tailles et spécifications');

-- Insérer des articles dans la table Article
INSERT INTO Article (nom_article, designation, prix, quantite_stock, id_categorie)
VALUES
('iPhone 13', 'Smartphone Apple 128Go', 799.99, 50, 1),
('Samsung Galaxy S21', 'Smartphone Samsung 128Go', 699.99, 30, 1),
('Casque Bluetooth', 'Casque sans fil compatible tous appareils', 99.99, 150, 2),
('Tablette Samsung Tab S7', 'Tablette Samsung 11 pouces 128Go', 649.99, 40, 3);

-- Insérer des commandes dans la table Commande
INSERT INTO Commande (montant_total, statut, date_commande, date_livraison, id_client)
VALUES 
(899.98, 'en traitement', '2024-11-01 10:00:00', '2024-11-05', 1),  -- Client 1
(799.99, 'expédiée', '2024-11-02 14:30:00', '2024-11-06', 2),  -- Client 2
(649.99, 'livrée', '2024-11-03 09:15:00', '2024-11-07', 3);  -- Client 3

-- Insérer dans la table Panier
INSERT INTO Panier (id_client)
VALUES
(1),  -- Client 1, iPhone 13
(1),  -- Client 1, Samsung Galaxy S21
(2),  -- Client 2, Casque Bluetooth
(3);  -- Client 3, Tablette Samsung Tab S7

-- Insérer des paiements dans la table Paiement
INSERT INTO Paiement (montant, mode_paiement, statut, id_commande)
VALUES 
(899.98, 'carte bancaire', 'réussi', 1),  -- Commande 1
(799.99, 'PayPal', 'réussi', 2),  -- Commande 2
(649.99, 'virement', 'réussi', 3);  -- Commande 3

-- Insérer des détails de commande dans la table Contenir
INSERT INTO Contenir (id_commande, id_article, quantite, prix_unitaire)
VALUES 
(1, 1, 1, 799.99),  -- Commande 1, 1 iPhone 13
(1, 2, 1, 699.99),  -- Commande 1, 1 Samsung Galaxy S21
(2, 3, 1, 99.99),  -- Commande 2, 1 Casque Bluetooth
(3, 4, 1, 649.99);  -- Commande 3, 1 Tablette Samsung Tab S7


-- Insérer des détails de commande dans la table Ajouter
INSERT INTO Ajouter(id_article, id_panier, prix_article, quantite_article)
VALUES
(1, 1, 799.99, 1),
(3, 2, 99.99, 2);

