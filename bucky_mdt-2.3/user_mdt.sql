CREATE TABLE `user_mdt` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`char_id` int(11) DEFAULT NULL,
	`notes` varchar(255) DEFAULT NULL,
	`mugshot_url` varchar(255) DEFAULT NULL,
	`bail` bit DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `user_convictions` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`char_id` int(11) DEFAULT NULL,
	`offense` varchar(255) DEFAULT NULL,
	`count` int(11) DEFAULT NULL,
	
	PRIMARY KEY (`id`)
);

CREATE TABLE `mdt_reports` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`char_id` int(11) DEFAULT NULL,
	`title` varchar(255) DEFAULT NULL,
	`incident` longtext DEFAULT NULL,
    `charges` longtext DEFAULT NULL,
    `author` varchar(255) DEFAULT NULL,
	`name` varchar(255) DEFAULT NULL,
    `date` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `mdt_warrants` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(255) DEFAULT NULL,
	`char_id` int(11) DEFAULT NULL,
	`report_id` int(11) DEFAULT NULL,
	`report_title` varchar(255) DEFAULT NULL,
	`charges` longtext DEFAULT NULL,
	`date` varchar(255) DEFAULT NULL,
	`expire` varchar(255) DEFAULT NULL,
	`notes` varchar(255) DEFAULT NULL,
	`author` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL,
	
       PRIMARY KEY (`id`)
);

CREATE TABLE `mdt_notes` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`title` varchar(255) DEFAULT NULL,
	`incident` longtext DEFAULT NULL,
    `author` varchar(255) DEFAULT NULL,
    `date` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`, `jailtime`) VALUES
(1, '1.1 Mord', 400, 0, 200),
(2, '1.2 Totschlag', 300, 0, 150),
(3, '1.2 Totschlag mit Kutsche / Pferd', 300, 0, 150),
(4, '1.2 Versuchte Tötung einer Amtsperson', 300, 0, 150),
(5, '1.1 Versuchter Mord', 200, 0, 100),
(6, '1.3 Tätlicher Angriff mit tödlicher Waffe auf Polizist', 200, 0, 100),
(7, '1.3 Tätlicher Angriff mit tödlicher Waffe', 150, 0, 75),
(8, '2.3 Selsbtjustiz', 250, 0, 125),
(9, '1.3 Körperverletzung', 150, 0, 75),
(10, '2.2 Erpressung', 200, 0, 100),
(11, '2.4 Entführung/Geiselnahme', 200, 0, 100),
(12, '2.12 Raubüberfall', 150, 0, 75),
(13, '2.12 Raubüberfall auf Geldtransporter', 200, 0, 100),
(14, '2.12 Raubüberfall auf Juweliergeschäft', 200, 0, 100),
(15, '2.12 Ladenüberfall', 150, 0, 75),
(16, '2.12 Raubüberfall auf ein Haus', 150, 0, 75),
(17, '2.8 Bestechung', 100, 0, 50),
(18, '2.9 Korruption', 250, 0, 125),
(19, '2.6 Flucht vor der Festnahme', 250, 0, 125),
(20, '3.1 Maskierung', 100, 0, 50),
(21, '2.13 Betrug', 150, 0, 75),
(22, "3.3 Überhöhte Geschwindigkeit", 20, 0, 0),
(23, "3.4 Rücksichtslose Gefährdung", 50, 0, 0),
(24, "2.6 Nichtanhalten", 50, 0, 0),
(25, "2.16 Drogenherstellung/-anbau", 150, 0, 75),
(26, '2.16 Besitz einer Droge', 200, 0, 100),
(27, '2.16 Verkauf/Vertrieb von Drogen', 200, 0, 100),
(28, '2.15 Verkauf/Vertrieb von illegalen Gegenständen', 250, 0, 125),
(29, '2.6 Strafvereitelung / Vertuschung', 150, 0, 75),
(30, '2.6 Unterschlagung', 150, 0, 75),
(31, '3.8 Vorzeigen einer Schusswaffe', 80, 0, 40),
(32, "3.8 Unerlaubte Entladung einer Feuerwaffe", 80, 0, 40),
(33, '2.7 Falsche Identität eines Regierungsbeamten', 250, 0, 125),
(34, '2.10 Identitätsdiebstahl', 200, 0, 100),
(35, "2.15 Besitz von gestohlenen Waren", 200, 0, 100),
(36, '2.11 Diebstahl', 200, 0, 100),
(37, '3.9 Tierschaendung', 100, 0, 50),
(38, '3.10 Wilderei', 100, 0, 50),
(39, '2.3 Verbrechen - Versuch der Begehung eines Vergehens/Verbrechens', 100, 0, 50),
(40, '2.6 Manipulation von Beweismitteln', 200, 0, 100),
(41, '2.8 Bestechung', 250, 0, 125),
(42, 'Krimineller Unfug', 100, 0, 50),
(43, '3.6 Nichtidentifizierung', 100, 0, 50),
(44, '3.7 Vorzeigepflicht', 100, 0, 50),
(45, '2.6 Behinderung staatlicher Amtspersonen', 250, 0, 125),
(46, "2.6 Widerstand gegen die Festnahme", 250, 0, 125),
(47, 'Störung der öffentlichen Ordnung', 50, 0, 0),
(48, "2.1 Bedrohung", 200, 0, 100),
(49, "2.14 Beschädigung von Staatseigentum", 250, 0, 125),
(50, "2.14 Beschädigung von fremden Eigentum", 125, 0, 60),
(51, "Nichtbefolgung einer rechtmäßigen Anordnung", 100, 0, 50),
(52, 'Falsche Anzeige', 100, 0, 50),
(53, '2.5 Unerlaubtes Betreten', 200, 0, 100),
(54, 'Herumlungern', 50, 0, 0),
(55, 'Unsittliche Entblößung', 50, 0, 0),
(56, '3.2 Beihilfe und Anstiftung', 100, 0, 50),
(57, 'siehe Bericht', 0, 0, 0),
(58, 'Mündliche Verwarnung', 0, 0, 0);
