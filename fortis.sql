-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.25-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for fortis
CREATE DATABASE IF NOT EXISTS `fortis` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `fortis`;

-- Dumping structure for table fortis.anwb_meldingen
CREATE TABLE IF NOT EXISTS `anwb_meldingen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` int(11) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.anwb_meldingen: ~0 rows (approximately)
DELETE FROM `anwb_meldingen`;
/*!40000 ALTER TABLE `anwb_meldingen` DISABLE KEYS */;
/*!40000 ALTER TABLE `anwb_meldingen` ENABLE KEYS */;

-- Dumping structure for table fortis.apartments
CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.apartments: ~18 rows (approximately)
DELETE FROM `apartments`;
/*!40000 ALTER TABLE `apartments` DISABLE KEYS */;
INSERT INTO `apartments` (`id`, `name`, `type`, `label`, `citizenid`) VALUES
	(1, 'apartment54726', 'apartment5', 'Fantastic Plaza 4726', 'HYV94545'),
	(2, 'apartment58236', 'apartment5', 'Fantastic Plaza 8236', 'CYW53116'),
	(3, 'apartment59286', 'apartment5', 'Fantastic Plaza 9286', 'SGA32203'),
	(4, 'apartment57245', 'apartment5', 'Fantastic Plaza 7245', 'EEF63115'),
	(5, 'apartment36563', 'apartment3', 'Integrity Way 6563', 'KIC58517'),
	(6, 'apartment27755', 'apartment2', 'Morningwood Blvd 7755', 'POD89459'),
	(7, 'apartment48376', 'apartment4', 'Tinsel Towers 8376', 'OPN56237'),
	(8, 'apartment54437', 'apartment5', 'Fantastic Plaza 4437', 'DAC96964'),
	(9, 'apartment15805', 'apartment1', 'South Rockford Drive 5805', 'MFS35960'),
	(10, 'apartment52749', 'apartment5', 'Fantastic Plaza 2749', 'WAM50871'),
	(11, 'apartment27534', 'apartment2', 'Morningwood Blvd 7534', 'CSS23711'),
	(12, 'apartment35583', 'apartment3', 'Integrity Way 5583', 'YWR79851'),
	(13, 'apartment53397', 'apartment5', 'Fantastic Plaza 3397', 'RZV59317'),
	(14, 'apartment56403', 'apartment5', 'Fantastic Plaza 6403', 'KSQ25658'),
	(15, 'apartment39078', 'apartment3', 'Integrity Way 9078', 'YYO05560'),
	(16, 'apartment58372', 'apartment5', 'Fantastic Plaza 8372', 'PXR11985'),
	(17, 'apartment58211', 'apartment5', 'Fantastic Plaza 8211', 'ZHK27525'),
	(18, 'apartment35538', 'apartment3', 'Integrity Way 5538', 'ZAC49531');
/*!40000 ALTER TABLE `apartments` ENABLE KEYS */;

-- Dumping structure for table fortis.api_tokens
CREATE TABLE IF NOT EXISTS `api_tokens` (
  `token` varchar(255) NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `time` int(25) DEFAULT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.api_tokens: ~0 rows (approximately)
DELETE FROM `api_tokens`;
/*!40000 ALTER TABLE `api_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_tokens` ENABLE KEYS */;

-- Dumping structure for table fortis.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=518 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.bans: ~0 rows (approximately)
DELETE FROM `bans`;
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Dumping structure for table fortis.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1114 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.bills: ~0 rows (approximately)
DELETE FROM `bills`;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;

-- Dumping structure for table fortis.bitcoinminen
CREATE TABLE IF NOT EXISTS `bitcoinminen` (
  `building` varchar(50) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `rackid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.bitcoinminen: ~0 rows (approximately)
DELETE FROM `bitcoinminen`;
/*!40000 ALTER TABLE `bitcoinminen` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitcoinminen` ENABLE KEYS */;

-- Dumping structure for table fortis.bm_berichten
CREATE TABLE IF NOT EXISTS `bm_berichten` (
  `bsn` varchar(50) DEFAULT NULL,
  `verzender` varchar(50) DEFAULT NULL,
  `bericht` text DEFAULT NULL,
  `datumtijd` date DEFAULT NULL,
  `gelezen` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.bm_berichten: ~0 rows (approximately)
DELETE FROM `bm_berichten`;
/*!40000 ALTER TABLE `bm_berichten` DISABLE KEYS */;
/*!40000 ALTER TABLE `bm_berichten` ENABLE KEYS */;

-- Dumping structure for table fortis.cellstraf
CREATE TABLE IF NOT EXISTS `cellstraf` (
  `steam` varchar(50) DEFAULT NULL,
  `maanden` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.cellstraf: ~0 rows (approximately)
DELETE FROM `cellstraf`;
/*!40000 ALTER TABLE `cellstraf` DISABLE KEYS */;
/*!40000 ALTER TABLE `cellstraf` ENABLE KEYS */;

-- Dumping structure for table fortis.crypto
CREATE TABLE IF NOT EXISTS `crypto` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.crypto: ~0 rows (approximately)
DELETE FROM `crypto`;
/*!40000 ALTER TABLE `crypto` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto` ENABLE KEYS */;

-- Dumping structure for table fortis.crypto_transactions
CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=939 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.crypto_transactions: ~0 rows (approximately)
DELETE FROM `crypto_transactions`;
/*!40000 ALTER TABLE `crypto_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto_transactions` ENABLE KEYS */;

-- Dumping structure for table fortis.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`#`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.dealers: ~0 rows (approximately)
DELETE FROM `dealers`;
/*!40000 ALTER TABLE `dealers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dealers` ENABLE KEYS */;

-- Dumping structure for table fortis.dpkeybinds
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keybind1` varchar(50) DEFAULT NULL,
  `emote1` varchar(50) DEFAULT NULL,
  `keybind2` varchar(50) DEFAULT NULL,
  `keybind3` varchar(50) DEFAULT NULL,
  `keybind4` varchar(50) DEFAULT NULL,
  `keybind5` varchar(50) DEFAULT NULL,
  `emote2` varchar(50) DEFAULT NULL,
  `emote3` varchar(50) DEFAULT NULL,
  `emote4` varchar(50) DEFAULT NULL,
  `emote5` varchar(50) DEFAULT NULL,
  `emote6` varchar(50) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.dpkeybinds: ~0 rows (approximately)
DELETE FROM `dpkeybinds`;
/*!40000 ALTER TABLE `dpkeybinds` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpkeybinds` ENABLE KEYS */;

-- Dumping structure for table fortis.drugslabs
CREATE TABLE IF NOT EXISTS `drugslabs` (
  `citizenid` varchar(50) DEFAULT NULL,
  `labinfo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `datum` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.drugslabs: ~1 rows (approximately)
DELETE FROM `drugslabs`;
/*!40000 ALTER TABLE `drugslabs` DISABLE KEYS */;
INSERT INTO `drugslabs` (`citizenid`, `labinfo`, `datum`) VALUES
	('CYW53116', '{"informatie":{"type":"pro"},"coords":{"x":2842.73,"z":24.73,"y":1457.01},"stash":{"naam":550428602430555}}', '0000-00-00');
/*!40000 ALTER TABLE `drugslabs` ENABLE KEYS */;

-- Dumping structure for table fortis.eenjaar
CREATE TABLE IF NOT EXISTS `eenjaar` (
  `steamid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.eenjaar: ~0 rows (approximately)
DELETE FROM `eenjaar`;
/*!40000 ALTER TABLE `eenjaar` DISABLE KEYS */;
/*!40000 ALTER TABLE `eenjaar` ENABLE KEYS */;

-- Dumping structure for table fortis.gangs
CREATE TABLE IF NOT EXISTS `gangs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `grades` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.gangs: ~0 rows (approximately)
DELETE FROM `gangs`;
/*!40000 ALTER TABLE `gangs` DISABLE KEYS */;
/*!40000 ALTER TABLE `gangs` ENABLE KEYS */;

-- Dumping structure for table fortis.gang_territoriums
CREATE TABLE IF NOT EXISTS `gang_territoriums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang` varchar(50) DEFAULT NULL,
  `points` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.gang_territoriums: ~0 rows (approximately)
DELETE FROM `gang_territoriums`;
/*!40000 ALTER TABLE `gang_territoriums` DISABLE KEYS */;
/*!40000 ALTER TABLE `gang_territoriums` ENABLE KEYS */;

-- Dumping structure for table fortis.gloveboxitems
CREATE TABLE IF NOT EXISTS `gloveboxitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `info` text DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.gloveboxitems: ~0 rows (approximately)
DELETE FROM `gloveboxitems`;
/*!40000 ALTER TABLE `gloveboxitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `gloveboxitems` ENABLE KEYS */;

-- Dumping structure for table fortis.gloveboxitemsnew
CREATE TABLE IF NOT EXISTS `gloveboxitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=1553 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.gloveboxitemsnew: ~2 rows (approximately)
DELETE FROM `gloveboxitemsnew`;
/*!40000 ALTER TABLE `gloveboxitemsnew` DISABLE KEYS */;
INSERT INTO `gloveboxitemsnew` (`id`, `plate`, `items`) VALUES
	(1551, '7OA202MU', '[]'),
	(1552, '6CY112QC', '[]');
/*!40000 ALTER TABLE `gloveboxitemsnew` ENABLE KEYS */;

-- Dumping structure for table fortis.groothandels
CREATE TABLE IF NOT EXISTS `groothandels` (
  `citizenid` varchar(50) DEFAULT NULL,
  `opslag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `werknemers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.groothandels: ~0 rows (approximately)
DELETE FROM `groothandels`;
/*!40000 ALTER TABLE `groothandels` DISABLE KEYS */;
/*!40000 ALTER TABLE `groothandels` ENABLE KEYS */;

-- Dumping structure for table fortis.houselocations
CREATE TABLE IF NOT EXISTS `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(2) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.houselocations: ~0 rows (approximately)
DELETE FROM `houselocations`;
/*!40000 ALTER TABLE `houselocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `houselocations` ENABLE KEYS */;

-- Dumping structure for table fortis.house_plants
CREATE TABLE IF NOT EXISTS `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building` (`building`),
  KEY `plantid` (`plantid`)
) ENGINE=InnoDB AUTO_INCREMENT=7123 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.house_plants: ~0 rows (approximately)
DELETE FROM `house_plants`;
/*!40000 ALTER TABLE `house_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_plants` ENABLE KEYS */;

-- Dumping structure for table fortis.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `grades` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.jobs: ~0 rows (approximately)
DELETE FROM `jobs`;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table fortis.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.lapraces: ~0 rows (approximately)
DELETE FROM `lapraces`;
/*!40000 ALTER TABLE `lapraces` DISABLE KEYS */;
/*!40000 ALTER TABLE `lapraces` ENABLE KEYS */;

-- Dumping structure for table fortis.moneysafes
CREATE TABLE IF NOT EXISTS `moneysafes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `safe` varchar(50) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT 0,
  `transactions` text NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.moneysafes: ~0 rows (approximately)
DELETE FROM `moneysafes`;
/*!40000 ALTER TABLE `moneysafes` DISABLE KEYS */;
/*!40000 ALTER TABLE `moneysafes` ENABLE KEYS */;

-- Dumping structure for table fortis.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.occasion_vehicles: ~0 rows (approximately)
DELETE FROM `occasion_vehicles`;
/*!40000 ALTER TABLE `occasion_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `occasion_vehicles` ENABLE KEYS */;

-- Dumping structure for table fortis.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.permissions: ~1 rows (approximately)
DELETE FROM `permissions`;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `steam`, `license`, `permission`) VALUES
	(1, 'Anykeys', 'steam:110000139cffd77', 'license:b8d74a1ececd5078486457d4eeea2879817842c1', 'god');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table fortis.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `invoiceid` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`#`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.phone_invoices: ~0 rows (approximately)
DELETE FROM `phone_invoices`;
/*!40000 ALTER TABLE `phone_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_invoices` ENABLE KEYS */;

-- Dumping structure for table fortis.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=6732 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.phone_messages: ~0 rows (approximately)
DELETE FROM `phone_messages`;
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table fortis.phone_tweets
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=5436 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.phone_tweets: ~0 rows (approximately)
DELETE FROM `phone_tweets`;
/*!40000 ALTER TABLE `phone_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_tweets` ENABLE KEYS */;

-- Dumping structure for table fortis.playerammo
CREATE TABLE IF NOT EXISTS `playerammo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `ammo` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=3638 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.playerammo: ~0 rows (approximately)
DELETE FROM `playerammo`;
/*!40000 ALTER TABLE `playerammo` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerammo` ENABLE KEYS */;

-- Dumping structure for table fortis.playeritems
CREATE TABLE IF NOT EXISTS `playeritems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=255891 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.playeritems: ~0 rows (approximately)
DELETE FROM `playeritems`;
/*!40000 ALTER TABLE `playeritems` DISABLE KEYS */;
/*!40000 ALTER TABLE `playeritems` ENABLE KEYS */;

-- Dumping structure for table fortis.players
CREATE TABLE IF NOT EXISTS `players` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tattoos` longtext DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`#`),
  KEY `citizenid` (`citizenid`),
  KEY `last_updated` (`last_updated`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.players: ~7 rows (approximately)
DELETE FROM `players`;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` (`#`, `citizenid`, `cid`, `steam`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`, `tattoos`, `ip`, `discord`) VALUES
	(11, 'CSS23711', 0, 'steam:11000010f7d727b', 'license:362837274e78752e2a4af0c79846940e900f371d', 'Ralph', '{"bank":10000,"cash":1000,"crypto":0}', '{"account":"NL09ABNA9114528313","cid":0,"gender":"man","backstory":"placeholder backstory","firstname":"g","birthdate":"2-2-1930","lastname":"g","new":true,"nationality":"Nederlands","phone":"0698312717"}', '{"onduty":false,"name":"unemployed","label":"Werkloos","payment":10}', '{"name":"geen","label":"Geen Gang"}', '{"a":213.61050415039063,"x":-571.2063598632813,"y":-269.43060302734377,"z":34.82008743286133}', '{"hunger":100,"inside":{"apartment":[]},"bloodtype":"A+","inlaststand":false,"currentapartment":"apartment27534","fingerprint":"iS534v55izx8162","armor":0,"jobrep":{"trucker":0,"hotdog":0,"tow":0,"taxi":0},"commandbinds":[],"status":[],"dealerrep":0,"thirst":100,"isdead":false,"craftingrep":0,"criminalrecord":{"hasRecord":false},"stress":0,"walletid":"FORTIS-24091254","injail":0,"callsign":"NO CALLSIGN","attachmentcraftingrep":0,"jailitems":[],"tracker":false,"phonedata":{"SerialNumber":20564778,"InstalledApps":[]},"licences":{"driver":true,"business":false},"ishandcuffed":false,"phone":[],"fitbit":[]}', '[{"info":{"lastname":"g","type":"A1-A2-A | AM-B | C1-C-CE","birthdate":"2-2-1930","firstname":"g"},"slot":1,"type":"item","name":"driver_license","amount":1},{"info":[],"slot":2,"type":"item","name":"phone","amount":1},{"info":{"birthdate":"2-2-1930","gender":"man","citizenid":"CSS23711","lastname":"g","nationality":"Nederlands","firstname":"g"},"slot":3,"type":"item","name":"id_card","amount":1}]', '2022-09-28 20:22:37', NULL, 'ip:212.187.57.79', 'discord:347072061526507520'),
	(12, 'YWR79851', 0, 'steam:110000117e8fcf8', 'license:5dd731aa3f40c9cb42a5edaa0ef3602b2310b693', '_WitteMuur', '{"bank":10010,"cash":1000,"crypto":0}', '{"account":"NL09ABNA3448299176","cid":0,"gender":"man","backstory":"placeholder backstory","firstname":"Lev","birthdate":"27-01-2004","lastname":"Benzon","new":true,"nationality":"Nederlands","phone":"0642925347"}', '{"onduty":false,"name":"unemployed","label":"Werkloos","payment":10}', '{"name":"geen","label":"Geen Gang"}', '{"y":-629.8475952148438,"x":262.2110290527344,"a":230.9303436279297,"z":41.33073043823242}', '{"hunger":95.8,"inside":{"apartment":[]},"bloodtype":"O+","inlaststand":false,"currentapartment":"apartment35583","fingerprint":"bj442r12GXl5305","armor":0,"jobrep":{"trucker":0,"hotdog":0,"tow":0,"taxi":0},"commandbinds":[],"status":[],"dealerrep":0,"thirst":96.2,"isdead":false,"craftingrep":0,"criminalrecord":{"hasRecord":false},"stress":0,"walletid":"FORTIS-38072374","injail":0,"callsign":"NO CALLSIGN","attachmentcraftingrep":0,"jailitems":[],"tracker":false,"phonedata":{"SerialNumber":36634657,"InstalledApps":[]},"licences":{"driver":true,"business":false},"ishandcuffed":false,"phone":[],"fitbit":[]}', '[{"info":{"lastname":"Benzon","type":"A1-A2-A | AM-B | C1-C-CE","birthdate":"27-01-2004","firstname":"Lev"},"slot":1,"type":"item","name":"driver_license","amount":1},{"info":[],"slot":2,"type":"item","name":"phone","amount":1},{"info":{"birthdate":"27-01-2004","gender":"man","citizenid":"YWR79851","lastname":"Benzon","nationality":"Nederlands","firstname":"Lev"},"slot":3,"type":"item","name":"id_card","amount":1}]', '2022-09-28 20:40:18', NULL, 'ip:178.226.195.10', 'discord:413380332197511168'),
	(13, 'RZV59317', 0, 'steam:11000011963a909', 'license:84893af85da7a2d7e7c0a5717b2657dd946c54aa', 'larsyr', '{"bank":9685,"cash":1000,"crypto":0}', '{"account":"NL04ABNA6133133641","cid":0,"gender":"man","backstory":"placeholder backstory","firstname":"Berto","birthdate":"07-11-2003","lastname":"Benzon","new":true,"nationality":"Nederlands","phone":"0615101453"}', '{"onduty":false,"name":"unemployed","label":"Werkloos","payment":10}', '{"name":"geen","label":"Geen Gang"}', '{"a":230.2893524169922,"x":-209.7010498046875,"y":-449.5904541015625,"z":32.70794677734375}', '{"hunger":95.8,"inside":{"apartment":[]},"bloodtype":"B+","inlaststand":false,"currentapartment":"apartment53397","fingerprint":"Mv102r91lkk4717","armor":0,"jobrep":{"trucker":0,"hotdog":0,"tow":0,"taxi":0},"commandbinds":[],"status":[],"dealerrep":0,"thirst":96.2,"isdead":false,"craftingrep":0,"criminalrecord":{"hasRecord":false},"stress":0,"walletid":"FORTIS-88416883","injail":0,"callsign":"NO CALLSIGN","attachmentcraftingrep":0,"jailitems":[],"tracker":false,"phonedata":{"SerialNumber":16441514,"InstalledApps":[]},"licences":{"driver":true,"business":false},"ishandcuffed":false,"phone":[],"fitbit":[]}', '[{"info":{"lastname":"Benzon","type":"A1-A2-A | AM-B | C1-C-CE","birthdate":"07-11-2003","firstname":"Berto"},"slot":1,"type":"item","name":"driver_license","amount":1},{"info":[],"slot":2,"type":"item","name":"phone","amount":1},{"info":{"birthdate":"07-11-2003","gender":"man","citizenid":"RZV59317","lastname":"Benzon","nationality":"Nederlands","firstname":"Berto"},"slot":3,"type":"item","name":"id_card","amount":1}]', '2022-09-28 20:41:20', NULL, 'ip:94.210.172.81', 'discord:356842251835408396'),
	(14, 'KSQ25658', 0, 'steam:11000013eab6174', 'license:e621125a6f55b3b980daf3bef217616d0edec4aa', 'DeanButBeans', '{"bank":3675,"cash":5150.0,"crypto":0}', '{"account":"NL01ABNA1838881098","cid":0,"gender":"man","backstory":"placeholder backstory","firstname":"Thijs","birthdate":"06-10-2000","lastname":"Achterham","new":true,"nationality":"Nederlands","phone":"0693055555"}', '{"onduty":false,"name":"unemployed","label":"Werkloos","payment":10}', '{"name":"geen","label":"Geen Gang"}', '{"a":154.31797790527345,"x":78.18973541259766,"y":6416.12548828125,"z":31.24873352050781}', '{"hunger":91.6,"inside":{"apartment":[]},"bloodtype":"O+","inlaststand":false,"currentapartment":"apartment56403","fingerprint":"Wp925N79auP6403","armor":0,"jobrep":{"trucker":0,"hotdog":0,"tow":0,"taxi":0},"commandbinds":[],"status":[],"dealerrep":0,"thirst":92.4,"isdead":false,"craftingrep":0,"criminalrecord":{"hasRecord":false},"stress":0,"walletid":"FORTIS-86341688","injail":0,"callsign":"NO CALLSIGN","attachmentcraftingrep":0,"jailitems":[],"tracker":false,"phonedata":{"SerialNumber":11469183,"InstalledApps":[]},"licences":{"driver":true,"business":false},"ishandcuffed":false,"phone":[],"fitbit":[]}', '[{"info":{"lastname":"Achterham","type":"A1-A2-A | AM-B | C1-C-CE","birthdate":"06-10-2000","firstname":"Thijs"},"slot":1,"type":"item","name":"driver_license","amount":1},{"info":[],"slot":2,"type":"item","name":"phone","amount":1},{"info":{"birthdate":"06-10-2000","gender":"man","citizenid":"KSQ25658","lastname":"Achterham","nationality":"Nederlands","firstname":"Thijs"},"slot":3,"type":"item","name":"id_card","amount":1},{"info":[],"slot":4,"type":"item","name":"lockpick","amount":1},{"info":"","slot":5,"type":"item","name":"painkillers","amount":2},{"info":[],"slot":9,"type":"item","name":"screwdriverset","amount":1}]', '2022-09-28 21:45:42', NULL, 'ip:86.88.33.106', 'discord:979102057304846346'),
	(15, 'YYO05560', 0, 'steam:11000010da38e67', 'license:3c4004ee3c85b5018042692be65341f0ddd04af8', 'Im_Davy', '{"bank":7660.0,"cash":150.0,"crypto":0}', '{"account":"NL04ABNA4686138035","cid":0,"gender":"man","backstory":"placeholder backstory","firstname":"Kawod","birthdate":"01-01-1999","lastname":"Zwakofzki","new":true,"nationality":"Nederlands","phone":"0690961371"}', '{"onduty":true,"name":"pakketpost","label":"Pakketpost","payment":50}', '{"name":"geen","label":"Geen Gang"}', '{"y":-1265.4627685546876,"x":245.56411743164063,"a":284.57586669921877,"z":28.67999076843261}', '{"hunger":83.19999999999999,"inside":{"apartment":[]},"bloodtype":"AB-","inlaststand":false,"currentapartment":"apartment39078","fingerprint":"Cm118S40HBw5689","armor":0,"jobrep":{"trucker":0,"hotdog":0,"tow":0,"taxi":0},"commandbinds":[],"status":[],"dealerrep":0,"thirst":84.80000000000001,"isdead":true,"craftingrep":0,"criminalrecord":{"hasRecord":false},"stress":0,"walletid":"FORTIS-17824978","injail":0,"callsign":"NO CALLSIGN","attachmentcraftingrep":0,"jailitems":[],"tracker":false,"phonedata":{"SerialNumber":60183376,"InstalledApps":[]},"licences":{"driver":true,"business":false},"ishandcuffed":false,"phone":[],"fitbit":[]}', '[{"info":{"lastname":"Zwakofzki","type":"A1-A2-A | AM-B | C1-C-CE","birthdate":"01-01-1999","firstname":"Kawod"},"slot":1,"type":"item","name":"driver_license","amount":1},{"info":[],"slot":2,"type":"item","name":"phone","amount":1},{"info":{"birthdate":"01-01-1999","gender":"man","citizenid":"YYO05560","lastname":"Zwakofzki","nationality":"Nederlands","firstname":"Kawod"},"slot":3,"type":"item","name":"id_card","amount":1},{"info":[],"slot":4,"type":"item","name":"screwdriverset","amount":1},{"info":[],"slot":5,"type":"item","name":"lockpick","amount":1},{"info":[],"slot":6,"type":"item","name":"repairkit","amount":4}]', '2022-09-28 21:44:20', NULL, 'ip:86.95.93.136', 'discord:764192627863584778'),
	(17, 'ZHK27525', 0, 'steam:1100001345581d4', 'license:f63a0ecd380519bed45e9faafcf1aabfc93a6326', 'rigss', '{"bank":10000,"cash":1000,"crypto":0}', '{"account":"NL02ABNA5721467427","cid":0,"gender":"man","backstory":"placeholder backstory","firstname":"Lmao","birthdate":"20-08-1998","lastname":"Leak","new":true,"nationality":"Nederlands","phone":"0684285481"}', '{"onduty":false,"name":"unemployed","label":"Werkloos","payment":10}', '{"name":"geen","label":"Geen Gang"}', '{"a":181.50294494628907,"x":294.0431213378906,"y":-1080.113037109375,"z":29.40327644348144}', '{"hunger":100,"inside":{"apartment":[]},"bloodtype":"B+","inlaststand":false,"currentapartment":"apartment58211","fingerprint":"iT757l11IIK9764","armor":0,"jobrep":{"trucker":0,"hotdog":0,"tow":0,"taxi":0},"commandbinds":[],"status":[],"dealerrep":0,"thirst":100,"isdead":false,"craftingrep":0,"criminalrecord":{"hasRecord":false},"stress":0,"walletid":"FORTIS-25930446","injail":0,"callsign":"NO CALLSIGN","attachmentcraftingrep":0,"jailitems":[],"tracker":false,"phonedata":{"SerialNumber":31429036,"InstalledApps":[]},"licences":{"driver":true,"business":false},"ishandcuffed":false,"phone":[],"fitbit":[]}', '[{"info":{"lastname":"Leak","type":"A1-A2-A | AM-B | C1-C-CE","birthdate":"20-08-1998","firstname":"Lmao"},"slot":1,"type":"item","name":"driver_license","amount":1},{"info":[],"slot":2,"type":"item","name":"phone","amount":1},{"info":{"birthdate":"20-08-1998","gender":"man","citizenid":"ZHK27525","lastname":"Leak","nationality":"Nederlands","firstname":"Lmao"},"slot":3,"type":"item","name":"id_card","amount":1}]', '2022-09-28 22:46:32', NULL, 'ip:84.17.46.167', 'discord:347899819681120259'),
	(18, 'ZAC49531', 0, 'steam:110000139cffd77', 'license:b8d74a1ececd5078486457d4eeea2879817842c1', 'Anykeys', '{"cash":1000,"bank":-3570,"crypto":9700}', '{"new":true,"nationality":"Nederlands","gender":"man","cid":0,"birthdate":"12-12-1999","phone":"0627837456","backstory":"placeholder backstory","account":"NL06ABNA5274146285","firstname":"Andre","lastname":"kees"}', '{"name":"taxi","label":"Taxi","payment":50,"onduty":true}', '{"name":"geen","label":"Geen Gang"}', '{"x":-175.6128082275391,"a":198.13540649414066,"z":93.01524353027344,"y":243.7141876220703}', '{"tracker":false,"callsign":"NO CALLSIGN","craftingrep":0,"inlaststand":false,"fitbit":[],"bloodtype":"AB+","jailitems":[],"currentapartment":"apartment35538","injail":0,"dealerrep":0,"licences":{"business":false,"driver":true},"stress":0,"isdead":false,"criminalrecord":{"hasRecord":false},"attachmentcraftingrep":0,"hunger":70.59999999999998,"inside":{"apartment":[]},"thirst":73.40000000000002,"phone":[],"walletid":"zb-12456597","phonedata":{"InstalledApps":[],"SerialNumber":12402343},"armor":0,"jobrep":{"taxi":0,"tow":0,"hotdog":0,"trucker":0},"ishandcuffed":false,"status":[],"commandbinds":[],"fingerprint":"ZL592T16PMC4179"}', '[{"name":"driver_license","info":{"firstname":"Andre","birthdate":"12-12-1999","lastname":"kees","type":"A1-A2-A | AM-B | C1-C-CE"},"slot":1,"amount":1,"type":"item"},{"name":"id_card","info":{"citizenid":"ZAC49531","nationality":"Nederlands","gender":"man","firstname":"Andre","birthdate":"12-12-1999","lastname":"kees"},"slot":2,"amount":1,"type":"item"},{"name":"phone","info":[],"slot":3,"amount":1,"type":"item"},{"name":"fortel","info":[],"slot":4,"amount":1,"type":"item"}]', '2022-10-02 09:04:50', NULL, 'ip:80.57.41.232', 'discord:696770352092807169');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;

-- Dumping structure for table fortis.playerskins
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.playerskins: ~17 rows (approximately)
DELETE FROM `playerskins`;
/*!40000 ALTER TABLE `playerskins` DISABLE KEYS */;
INSERT INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
	(1, 'HYV94545', '1885233650', '{"lipstick":{"texture":1,"item":-1,"defaultTexture":1,"defaultItem":-1},"mask":{"texture":0,"item":0,"defaultTexture":0,"defaultItem":0},"accessory":{"texture":0,"item":0,"defaultTexture":0,"defaultItem":0},"ageing":{"texture":0,"item":-1,"defaultTexture":0,"defaultItem":-1},"face":{"texture":0,"item":3,"defaultTexture":0,"defaultItem":0},"makeup":{"texture":1,"item":-1,"defaultTexture":1,"defaultItem":-1},"ear":{"texture":0,"item":-1,"defaultTexture":0,"defaultItem":-1},"pants":{"texture":0,"item":0,"defaultTexture":0,"defaultItem":0},"glass":{"texture":0,"item":0,"defaultTexture":0,"defaultItem":0},"decals":{"texture":0,"item":0,"defaultTexture":0,"defaultItem":0},"beard":{"texture":1,"item":-1,"defaultTexture":1,"defaultItem":-1},"hair":{"texture":0,"item":0,"defaultTexture":0,"defaultItem":0},"watch":{"texture":0,"item":-1,"defaultTexture":0,"defaultItem":-1},"shoes":{"texture":0,"item":1,"defaultTexture":0,"defaultItem":1},"eyebrows":{"texture":1,"item":-1,"defaultTexture":1,"defaultItem":-1},"t-shirt":{"texture":0,"item":21,"defaultTexture":0,"defaultItem":15},"hat":{"texture":0,"item":-1,"defaultTexture":0,"defaultItem":-1},"torso2":{"texture":0,"item":14,"defaultTexture":0,"defaultItem":0},"arms":{"texture":0,"item":2,"defaultTexture":0,"defaultItem":0},"bag":{"texture":0,"item":0,"defaultTexture":0,"defaultItem":0},"vest":{"texture":0,"item":13,"defaultTexture":0,"defaultItem":0},"blush":{"texture":1,"item":-1,"defaultTexture":1,"defaultItem":-1},"bracelet":{"texture":0,"item":-1,"defaultTexture":0,"defaultItem":-1}}', 1),
	(2, 'CYW53116', '1885233650', '{"eyebrows":{"item":-1,"defaultTexture":1,"texture":1,"defaultItem":-1},"vest":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"shoes":{"item":1,"defaultTexture":0,"texture":0,"defaultItem":1},"blush":{"item":-1,"defaultTexture":1,"texture":1,"defaultItem":-1},"arms":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"makeup":{"item":-1,"defaultTexture":1,"texture":1,"defaultItem":-1},"ear":{"item":-1,"defaultTexture":0,"texture":0,"defaultItem":-1},"glass":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"hat":{"item":-1,"defaultTexture":0,"texture":0,"defaultItem":-1},"face":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"pants":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"hair":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"lipstick":{"item":-1,"defaultTexture":1,"texture":1,"defaultItem":-1},"ageing":{"item":-1,"defaultTexture":0,"texture":0,"defaultItem":-1},"decals":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"accessory":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"bracelet":{"item":-1,"defaultTexture":0,"texture":0,"defaultItem":-1},"watch":{"item":-1,"defaultTexture":0,"texture":0,"defaultItem":-1},"mask":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"bag":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"torso2":{"item":0,"defaultTexture":0,"texture":0,"defaultItem":0},"t-shirt":{"item":15,"defaultTexture":0,"texture":0,"defaultItem":15},"beard":{"item":-1,"defaultTexture":1,"texture":1,"defaultItem":-1}}', 1),
	(3, 'SGA32203', '1885233650', '{"hat":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"ageing":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"pants":{"defaultTexture":0,"texture":0,"item":4,"defaultItem":0},"shoes":{"defaultTexture":0,"texture":0,"item":10,"defaultItem":1},"blush":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"beard":{"defaultTexture":1,"texture":1,"item":0,"defaultItem":-1},"bracelet":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"hair":{"defaultTexture":0,"texture":0,"item":19,"defaultItem":0},"lipstick":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"accessory":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"face":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"mask":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"watch":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"torso2":{"defaultTexture":0,"texture":0,"item":4,"defaultItem":0},"t-shirt":{"defaultTexture":0,"texture":1,"item":16,"defaultItem":15},"vest":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"eyebrows":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"glass":{"defaultTexture":0,"texture":2,"item":5,"defaultItem":0},"makeup":{"defaultTexture":1,"texture":1,"item":-1,"defaultItem":-1},"arms":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"decals":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0},"ear":{"defaultTexture":0,"texture":0,"item":-1,"defaultItem":-1},"bag":{"defaultTexture":0,"texture":0,"item":0,"defaultItem":0}}', 1),
	(4, 'EEF63115', '1885233650', '{"torso2":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"pants":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"face":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"ear":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"hair":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"eyebrows":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"glass":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"ageing":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"decals":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"accessory":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"makeup":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"hat":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"blush":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"beard":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"bracelet":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"vest":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"lipstick":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"bag":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"watch":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"t-shirt":{"texture":0,"item":15,"defaultItem":15,"defaultTexture":0},"shoes":{"texture":0,"item":1,"defaultItem":1,"defaultTexture":0},"arms":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"mask":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0}}', 1),
	(5, 'POD89459', '1885233650', '{"pants":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"glass":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"t-shirt":{"defaultTexture":0,"defaultItem":15,"texture":0,"item":15},"mask":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"ageing":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"hair":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":12},"lipstick":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"vest":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"decals":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"face":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"accessory":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"makeup":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"bracelet":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"shoes":{"defaultTexture":0,"defaultItem":1,"texture":0,"item":1},"torso2":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":14},"eyebrows":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"beard":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":3},"watch":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"ear":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"bag":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"hat":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"arms":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"blush":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1}}', 1),
	(6, 'OPN56237', '1885233650', '{"lipstick":{"defaultItem":-1,"defaultTexture":1,"texture":1,"item":-1},"pants":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"glass":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"vest":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"blush":{"defaultItem":-1,"defaultTexture":1,"texture":1,"item":-1},"hat":{"defaultItem":-1,"defaultTexture":0,"texture":0,"item":-1},"makeup":{"defaultItem":-1,"defaultTexture":1,"texture":1,"item":-1},"eyebrows":{"defaultItem":-1,"defaultTexture":1,"texture":1,"item":-1},"face":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"hair":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":14},"decals":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"torso2":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":1},"arms":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"bracelet":{"defaultItem":-1,"defaultTexture":0,"texture":0,"item":-1},"accessory":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"watch":{"defaultItem":-1,"defaultTexture":0,"texture":0,"item":-1},"t-shirt":{"defaultItem":15,"defaultTexture":0,"texture":0,"item":15},"bag":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"mask":{"defaultItem":0,"defaultTexture":0,"texture":0,"item":0},"beard":{"defaultItem":-1,"defaultTexture":1,"texture":1,"item":-1},"shoes":{"defaultItem":1,"defaultTexture":0,"texture":0,"item":1},"ear":{"defaultItem":-1,"defaultTexture":0,"texture":0,"item":-1},"ageing":{"defaultItem":-1,"defaultTexture":0,"texture":0,"item":-1}}', 1),
	(7, 'DAC96964', '1885233650', '{"face":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":1},"eyebrows":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"hair":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"decals":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"accessory":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"t-shirt":{"defaultTexture":0,"defaultItem":15,"texture":0,"item":15},"bracelet":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"shoes":{"defaultTexture":0,"defaultItem":1,"texture":0,"item":1},"ear":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"pants":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"watch":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"mask":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"glass":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"makeup":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"hat":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"bag":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"vest":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":1},"torso2":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":1},"arms":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":1},"ageing":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"blush":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"lipstick":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"beard":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1}}', 1),
	(8, 'MFS35960', '1885233650', '{"beard":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"torso2":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"lipstick":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"watch":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"hair":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"bracelet":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"arms":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"shoes":{"defaultTexture":0,"defaultItem":1,"texture":0,"item":1},"face":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"hat":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"bag":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"ageing":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"pants":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"accessory":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"ear":{"defaultTexture":0,"defaultItem":-1,"texture":0,"item":-1},"eyebrows":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"t-shirt":{"defaultTexture":0,"defaultItem":15,"texture":0,"item":15},"glass":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"mask":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"vest":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"decals":{"defaultTexture":0,"defaultItem":0,"texture":0,"item":0},"blush":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1},"makeup":{"defaultTexture":1,"defaultItem":-1,"texture":1,"item":-1}}', 1),
	(9, 'WAM50871', '1885233650', '{"watch":{"item":-1,"defaultTexture":0,"defaultItem":-1,"texture":0},"ear":{"item":-1,"defaultTexture":0,"defaultItem":-1,"texture":0},"glass":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":0},"face":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":4},"ageing":{"item":-1,"defaultTexture":0,"defaultItem":-1,"texture":0},"vest":{"item":4,"defaultTexture":0,"defaultItem":0,"texture":1},"lipstick":{"item":-1,"defaultTexture":1,"defaultItem":-1,"texture":1},"pants":{"item":4,"defaultTexture":0,"defaultItem":0,"texture":0},"blush":{"item":-1,"defaultTexture":1,"defaultItem":-1,"texture":1},"t-shirt":{"item":15,"defaultTexture":0,"defaultItem":15,"texture":0},"accessory":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":0},"beard":{"item":-1,"defaultTexture":1,"defaultItem":-1,"texture":1},"makeup":{"item":-1,"defaultTexture":1,"defaultItem":-1,"texture":1},"bracelet":{"item":-1,"defaultTexture":0,"defaultItem":-1,"texture":0},"hat":{"item":12,"defaultTexture":0,"defaultItem":-1,"texture":0},"arms":{"item":5,"defaultTexture":0,"defaultItem":0,"texture":0},"bag":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":0},"mask":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":0},"eyebrows":{"item":-1,"defaultTexture":1,"defaultItem":-1,"texture":1},"torso2":{"item":17,"defaultTexture":0,"defaultItem":0,"texture":5},"decals":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":0},"shoes":{"item":1,"defaultTexture":0,"defaultItem":1,"texture":0},"hair":{"item":1,"defaultTexture":0,"defaultItem":0,"texture":5}}', 1),
	(10, 'CSS23711', '1885233650', '{"face":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"beard":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"eyebrows":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"mask":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"bracelet":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"blush":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"ear":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"vest":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"shoes":{"texture":0,"defaultTexture":0,"defaultItem":1,"item":1},"hair":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"torso2":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"ageing":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"arms":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"pants":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"watch":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"accessory":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"glass":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"hat":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"makeup":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"t-shirt":{"texture":0,"defaultTexture":0,"defaultItem":15,"item":15},"bag":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"decals":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"lipstick":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1}}', 1),
	(11, 'RZV59317', '1885233650', '{"bag":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"eyebrows":{"item":-1,"defaultItem":-1,"texture":1,"defaultTexture":1},"makeup":{"item":-1,"defaultItem":-1,"texture":1,"defaultTexture":1},"hair":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"lipstick":{"item":-1,"defaultItem":-1,"texture":1,"defaultTexture":1},"hat":{"item":-1,"defaultItem":-1,"texture":0,"defaultTexture":0},"blush":{"item":-1,"defaultItem":-1,"texture":1,"defaultTexture":1},"accessory":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"watch":{"item":-1,"defaultItem":-1,"texture":0,"defaultTexture":0},"t-shirt":{"item":15,"defaultItem":15,"texture":0,"defaultTexture":0},"decals":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"pants":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"bracelet":{"item":-1,"defaultItem":-1,"texture":0,"defaultTexture":0},"ear":{"item":-1,"defaultItem":-1,"texture":0,"defaultTexture":0},"beard":{"item":-1,"defaultItem":-1,"texture":1,"defaultTexture":1},"mask":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"glass":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"shoes":{"item":1,"defaultItem":1,"texture":0,"defaultTexture":0},"vest":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"face":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"arms":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"torso2":{"item":0,"defaultItem":0,"texture":0,"defaultTexture":0},"ageing":{"item":-1,"defaultItem":-1,"texture":0,"defaultTexture":0}}', 1),
	(12, 'YWR79851', '1885233650', '{"arms":{"defaultTexture":0,"item":22,"texture":0,"defaultItem":0},"pants":{"defaultTexture":0,"item":24,"texture":0,"defaultItem":0},"blush":{"defaultTexture":1,"item":-1,"texture":1,"defaultItem":-1},"beard":{"defaultTexture":1,"item":5,"texture":1,"defaultItem":-1},"mask":{"defaultTexture":0,"item":119,"texture":5,"defaultItem":0},"lipstick":{"defaultTexture":1,"item":-1,"texture":1,"defaultItem":-1},"hair":{"defaultTexture":0,"item":19,"texture":0,"defaultItem":0},"bracelet":{"defaultTexture":0,"item":-1,"texture":0,"defaultItem":-1},"t-shirt":{"defaultTexture":0,"item":21,"texture":0,"defaultItem":15},"face":{"defaultTexture":0,"item":44,"texture":0,"defaultItem":0},"decals":{"defaultTexture":0,"item":0,"texture":0,"defaultItem":0},"shoes":{"defaultTexture":0,"item":8,"texture":0,"defaultItem":1},"vest":{"defaultTexture":0,"item":0,"texture":0,"defaultItem":0},"makeup":{"defaultTexture":1,"item":-1,"texture":1,"defaultItem":-1},"ageing":{"defaultTexture":0,"item":-1,"texture":0,"defaultItem":-1},"bag":{"defaultTexture":0,"item":0,"texture":0,"defaultItem":0},"ear":{"defaultTexture":0,"item":-1,"texture":0,"defaultItem":-1},"hat":{"defaultTexture":0,"item":50,"texture":0,"defaultItem":-1},"glass":{"defaultTexture":0,"item":3,"texture":0,"defaultItem":0},"eyebrows":{"defaultTexture":1,"item":-1,"texture":1,"defaultItem":-1},"accessory":{"defaultTexture":0,"item":0,"texture":0,"defaultItem":0},"watch":{"defaultTexture":0,"item":-1,"texture":0,"defaultItem":-1},"torso2":{"defaultTexture":0,"item":142,"texture":11,"defaultItem":0}}', 1),
	(13, 'KSQ25658', '1885233650', '{"ageing":{"item":-1,"defaultTexture":0,"defaultItem":-1,"texture":0},"watch":{"item":-1,"defaultTexture":0,"defaultItem":-1,"texture":0},"vest":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":0},"t-shirt":{"item":15,"defaultTexture":0,"defaultItem":15,"texture":0},"pants":{"item":4,"defaultTexture":0,"defaultItem":0,"texture":0},"hat":{"item":50,"defaultTexture":0,"defaultItem":-1,"texture":0},"mask":{"item":72,"defaultTexture":0,"defaultItem":0,"texture":0},"hair":{"item":19,"defaultTexture":0,"defaultItem":0,"texture":0},"eyebrows":{"item":30,"defaultTexture":1,"defaultItem":-1,"texture":1},"shoes":{"item":12,"defaultTexture":0,"defaultItem":1,"texture":0},"makeup":{"item":-1,"defaultTexture":1,"defaultItem":-1,"texture":1},"arms":{"item":49,"defaultTexture":0,"defaultItem":0,"texture":0},"bracelet":{"item":-1,"defaultTexture":0,"defaultItem":-1,"texture":0},"blush":{"item":-1,"defaultTexture":1,"defaultItem":-1,"texture":1},"decals":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":0},"lipstick":{"item":-1,"defaultTexture":1,"defaultItem":-1,"texture":1},"accessory":{"item":17,"defaultTexture":0,"defaultItem":0,"texture":0},"ear":{"item":12,"defaultTexture":0,"defaultItem":-1,"texture":0},"bag":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":0},"glass":{"item":5,"defaultTexture":0,"defaultItem":0,"texture":0},"torso2":{"item":111,"defaultTexture":0,"defaultItem":0,"texture":3},"beard":{"item":3,"defaultTexture":1,"defaultItem":-1,"texture":1},"face":{"item":0,"defaultTexture":0,"defaultItem":0,"texture":8}}', 1),
	(14, 'YYO05560', '1885233650', '{"ageing":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"hat":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"watch":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"eyebrows":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"ear":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"shoes":{"texture":0,"defaultTexture":0,"defaultItem":1,"item":5},"decals":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"accessory":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"bracelet":{"texture":0,"defaultTexture":0,"defaultItem":-1,"item":-1},"face":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"glass":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"mask":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"bag":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"beard":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"torso2":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":20},"t-shirt":{"texture":0,"defaultTexture":0,"defaultItem":15,"item":23},"arms":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":22},"makeup":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"hair":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"lipstick":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"blush":{"texture":1,"defaultTexture":1,"defaultItem":-1,"item":-1},"vest":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":0},"pants":{"texture":0,"defaultTexture":0,"defaultItem":0,"item":18}}', 1),
	(15, 'PXR11985', '1885233650', '{"eyebrows":{"item":9,"texture":1,"defaultTexture":1,"defaultItem":-1},"pants":{"item":24,"texture":1,"defaultTexture":0,"defaultItem":0},"hair":{"item":19,"texture":1,"defaultTexture":0,"defaultItem":0},"watch":{"item":-1,"texture":0,"defaultTexture":0,"defaultItem":-1},"accessory":{"item":0,"texture":0,"defaultTexture":0,"defaultItem":0},"makeup":{"item":-1,"texture":1,"defaultTexture":1,"defaultItem":-1},"ear":{"item":-1,"texture":0,"defaultTexture":0,"defaultItem":-1},"ageing":{"item":-1,"texture":0,"defaultTexture":0,"defaultItem":-1},"decals":{"item":0,"texture":0,"defaultTexture":0,"defaultItem":0},"beard":{"item":18,"texture":1,"defaultTexture":1,"defaultItem":-1},"bracelet":{"item":-1,"texture":0,"defaultTexture":0,"defaultItem":-1},"glass":{"item":0,"texture":0,"defaultTexture":0,"defaultItem":0},"hat":{"item":-1,"texture":0,"defaultTexture":0,"defaultItem":-1},"bag":{"item":0,"texture":0,"defaultTexture":0,"defaultItem":0},"face":{"item":0,"texture":8,"defaultTexture":0,"defaultItem":0},"vest":{"item":0,"texture":0,"defaultTexture":0,"defaultItem":0},"blush":{"item":-1,"texture":1,"defaultTexture":1,"defaultItem":-1},"shoes":{"item":10,"texture":0,"defaultTexture":0,"defaultItem":1},"mask":{"item":0,"texture":0,"defaultTexture":0,"defaultItem":0},"torso2":{"item":32,"texture":3,"defaultTexture":0,"defaultItem":0},"t-shirt":{"item":31,"texture":2,"defaultTexture":0,"defaultItem":15},"arms":{"item":1,"texture":0,"defaultTexture":0,"defaultItem":0},"lipstick":{"item":-1,"texture":1,"defaultTexture":1,"defaultItem":-1}}', 1),
	(16, 'ZHK27525', '1885233650', '{"hair":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"face":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"eyebrows":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"blush":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"glass":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"makeup":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"pants":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"ear":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"arms":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"decals":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"accessory":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"bracelet":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"lipstick":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"beard":{"texture":1,"item":-1,"defaultItem":-1,"defaultTexture":1},"bag":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"t-shirt":{"texture":0,"item":15,"defaultItem":15,"defaultTexture":0},"mask":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"shoes":{"texture":0,"item":1,"defaultItem":1,"defaultTexture":0},"watch":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"hat":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0},"torso2":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"vest":{"texture":0,"item":0,"defaultItem":0,"defaultTexture":0},"ageing":{"texture":0,"item":-1,"defaultItem":-1,"defaultTexture":0}}', 1),
	(18, 'ZAC49531', '1885233650', '{"watch":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"accessory":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"bag":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"pants":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"mask":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"decals":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"face":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"blush":{"texture":1,"defaultItem":-1,"defaultTexture":1,"item":-1},"vest":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":18},"ear":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"t-shirt":{"texture":0,"defaultItem":15,"defaultTexture":0,"item":0},"torso2":{"texture":1,"defaultItem":0,"defaultTexture":0,"item":0},"hair":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"bracelet":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"hat":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"arms":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"eyebrows":{"texture":1,"defaultItem":-1,"defaultTexture":1,"item":-1},"makeup":{"texture":1,"defaultItem":-1,"defaultTexture":1,"item":-1},"beard":{"texture":1,"defaultItem":-1,"defaultTexture":1,"item":-1},"lipstick":{"texture":1,"defaultItem":-1,"defaultTexture":1,"item":-1},"shoes":{"texture":0,"defaultItem":1,"defaultTexture":0,"item":1},"glass":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"ageing":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1}}', 1);
/*!40000 ALTER TABLE `playerskins` ENABLE KEYS */;

-- Dumping structure for table fortis.player_boats
CREATE TABLE IF NOT EXISTS `player_boats` (
  `#` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `boathouse` varchar(50) DEFAULT NULL,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `state` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.player_boats: ~4 rows (approximately)
DELETE FROM `player_boats`;
/*!40000 ALTER TABLE `player_boats` DISABLE KEYS */;
INSERT INTO `player_boats` (`#`, `citizenid`, `model`, `plate`, `boathouse`, `fuel`, `state`) VALUES
	(16, 'QRA63694', 'dinghy', 'IDEK6943', 'lsymc', 100, 1),
	(17, 'QRA63694', 'dinghy', 'IDEK9620', 'lsymc', 100, 1),
	(18, 'QRA63694', 'dinghy', 'IDEK7789', 'lsymc', 100, 1),
	(0, 'QEJ34052', 'dinghy', 'IDEK8417', NULL, 100, 0);
/*!40000 ALTER TABLE `player_boats` ENABLE KEYS */;

-- Dumping structure for table fortis.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=12433 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.player_contacts: ~0 rows (approximately)
DELETE FROM `player_contacts`;
/*!40000 ALTER TABLE `player_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_contacts` ENABLE KEYS */;

-- Dumping structure for table fortis.player_houses
CREATE TABLE IF NOT EXISTS `player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `house` (`house`),
  KEY `citizenid` (`citizenid`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.player_houses: ~0 rows (approximately)
DELETE FROM `player_houses`;
/*!40000 ALTER TABLE `player_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_houses` ENABLE KEYS */;

-- Dumping structure for table fortis.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=67024 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.player_mails: ~1 rows (approximately)
DELETE FROM `player_mails`;
/*!40000 ALTER TABLE `player_mails` DISABLE KEYS */;
INSERT INTO `player_mails` (`id`, `citizenid`, `sender`, `subject`, `message`, `read`, `mailid`, `date`, `button`) VALUES
	(67023, 'ZAC49531', 'Central Justitieel Incassobureau', 'Openbaar Ministerie', 'Beste Mr. kees,<br /><br />Het centraal justitieel incasso bureau (CJIB) heeft de boetes verstekt van de wout.<br />Er is <strong>€13920</strong> van je bankrekening afgeschreven.<br /><br />Met vriendelijke groet,<br />Centraal Justitieel Incassobureau', 0, 273410, '0000-00-00 00:00:00', '[]');
/*!40000 ALTER TABLE `player_mails` ENABLE KEYS */;

-- Dumping structure for table fortis.player_outfits
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `skin` text DEFAULT NULL,
  `outfitId` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `outfitId` (`outfitId`)
) ENGINE=InnoDB AUTO_INCREMENT=8972 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.player_outfits: ~2 rows (approximately)
DELETE FROM `player_outfits`;
/*!40000 ALTER TABLE `player_outfits` DISABLE KEYS */;
INSERT INTO `player_outfits` (`id`, `citizenid`, `outfitname`, `model`, `skin`, `outfitId`) VALUES
	(8970, 'YWR79851', 'outje', '1885233650', '{"bag":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"hat":{"defaultItem":-1,"texture":0,"item":50,"defaultTexture":0},"makeup":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"beard":{"defaultItem":-1,"texture":1,"item":5,"defaultTexture":1},"face":{"defaultItem":0,"texture":0,"item":44,"defaultTexture":0},"vest":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"accessory":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"lipstick":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"blush":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"watch":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"arms":{"defaultItem":0,"texture":0,"item":22,"defaultTexture":0},"shoes":{"defaultItem":1,"texture":0,"item":8,"defaultTexture":0},"hair":{"defaultItem":0,"texture":0,"item":19,"defaultTexture":0},"torso2":{"defaultItem":0,"texture":11,"item":142,"defaultTexture":0},"eyebrows":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"decals":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"ear":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"mask":{"defaultItem":0,"texture":5,"item":119,"defaultTexture":0},"pants":{"defaultItem":0,"texture":0,"item":24,"defaultTexture":0},"bracelet":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"ageing":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"glass":{"defaultItem":0,"texture":0,"item":3,"defaultTexture":0},"t-shirt":{"defaultItem":15,"texture":0,"item":21,"defaultTexture":0}}', 'outfit-7-7627'),
	(8971, 'YYO05560', 'Kawod clean', '1885233650', '{"bag":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"hat":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"makeup":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"beard":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"face":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"eyebrows":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"accessory":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"lipstick":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"decals":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"watch":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"arms":{"defaultItem":0,"texture":0,"item":22,"defaultTexture":0},"shoes":{"defaultItem":1,"texture":0,"item":5,"defaultTexture":0},"ear":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"torso2":{"defaultItem":0,"texture":0,"item":20,"defaultTexture":0},"pants":{"defaultItem":0,"texture":0,"item":18,"defaultTexture":0},"vest":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"blush":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"hair":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"mask":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"bracelet":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"ageing":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"glass":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"t-shirt":{"defaultItem":15,"texture":0,"item":23,"defaultTexture":0}}', 'outfit-2-7632');
/*!40000 ALTER TABLE `player_outfits` ENABLE KEYS */;

-- Dumping structure for table fortis.player_planes
CREATE TABLE IF NOT EXISTS `player_planes` (
  `steam` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `plane` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`mods`)),
  `plate` varchar(50) DEFAULT NULL,
  `hangar` varchar(50) DEFAULT NULL,
  `state` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.player_planes: ~0 rows (approximately)
DELETE FROM `player_planes`;
/*!40000 ALTER TABLE `player_planes` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_planes` ENABLE KEYS */;

-- Dumping structure for table fortis.player_vehicles
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  PRIMARY KEY (`#`),
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=2434 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.player_vehicles: ~2 rows (approximately)
DELETE FROM `player_vehicles`;
/*!40000 ALTER TABLE `player_vehicles` DISABLE KEYS */;
INSERT INTO `player_vehicles` (`#`, `steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `fakeplate`, `garage`, `fuel`, `engine`, `body`, `state`, `depotprice`, `drivingdistance`, `status`) VALUES
	(2432, 'steam:11000013eab6174', 'KSQ25658', 'esskey', '2035069708', '{"modSpeakers":-1,"modRightFender":-1,"modAPlate":-1,"modWindows":-1,"modDashboard":-1,"modFrame":-1,"modArmor":-1,"modLivery":-1,"modShifterLeavers":-1,"modTransmission":-1,"neonColor":[255,0,255],"modSeats":-1,"modHydrolic":-1,"dirtLevel":14.35130023956298,"modBrakes":-1,"modTurbo":false,"modFrontBumper":-1,"extras":[],"modPlateHolder":-1,"color1":29,"modSpoilers":-1,"modTank":-1,"modHood":-1,"wheels":6,"modFrontWheels":-1,"neonEnabled":[false,false,false,false],"modEngineBlock":-1,"plate":"7OA202MU","modXenon":false,"model":2035069708,"modGrille":-1,"modOrnaments":-1,"color2":112,"modTrimB":-1,"modExhaust":-1,"modDoorSpeaker":-1,"tyreSmokeColor":[255,255,255],"modTrunk":-1,"modAerials":-1,"modArchCover":-1,"modTrimA":-1,"modFender":-1,"modRearBumper":-1,"pearlescentColor":158,"modDial":-1,"modSuspension":-1,"modCustomTyres":false,"plateIndex":0,"modEngine":-1,"modSideSkirt":-1,"modStruts":-1,"wheelColor":131,"health":716,"modRoof":-1,"modBackWheels":-1,"modVanityPlate":-1,"windowTint":-1,"modSteeringWheel":-1,"modHorns":-1,"modSmokeEnabled":false,"modAirFilter":-1}', '7OA202MU', NULL, 'haanparking', 100, 1000, 1000, 1, 0, NULL, NULL),
	(2433, 'steam:110000140a23b66', 'PXR11985', 'esskey', '2035069708', '{}', '6CY112QC', NULL, 'sapcounsel', 100, 1000, 1000, 1, 0, NULL, NULL);
/*!40000 ALTER TABLE `player_vehicles` ENABLE KEYS */;

-- Dumping structure for table fortis.player_warns
CREATE TABLE IF NOT EXISTS `player_warns` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.player_warns: ~0 rows (approximately)
DELETE FROM `player_warns`;
/*!40000 ALTER TABLE `player_warns` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_warns` ENABLE KEYS */;

-- Dumping structure for table fortis.playtime
CREATE TABLE IF NOT EXISTS `playtime` (
  `steam` varchar(50) DEFAULT NULL,
  `playtime` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.playtime: ~0 rows (approximately)
DELETE FROM `playtime`;
/*!40000 ALTER TABLE `playtime` DISABLE KEYS */;
/*!40000 ALTER TABLE `playtime` ENABLE KEYS */;

-- Dumping structure for table fortis.playtime_final
CREATE TABLE IF NOT EXISTS `playtime_final` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) DEFAULT NULL,
  `minuten` int(11) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.playtime_final: ~16 rows (approximately)
DELETE FROM `playtime_final`;
/*!40000 ALTER TABLE `playtime_final` DISABLE KEYS */;
INSERT INTO `playtime_final` (`id`, `steam`, `minuten`) VALUES
	(1, 'steam:110000139cffd77', 136),
	(2, 'steam:11000013ca9e934', 8),
	(3, 'steam:11000014034f095', 2),
	(4, 'steam:11000011d475544', 2),
	(5, 'steam:110000147838bea', 11),
	(6, 'steam:11000011d3a711b', 3),
	(7, 'steam:11000011670ca6e', 2),
	(8, 'steam:1100001466f1605', 10),
	(9, 'steam:110000155e71ce2', 5),
	(10, 'steam:11000010f7d727b', 9),
	(11, 'steam:110000117e8fcf8', 12),
	(12, 'steam:11000011963a909', 11),
	(13, 'steam:11000013eab6174', 53),
	(14, 'steam:11000010da38e67', 45),
	(15, 'steam:110000140a23b66', 82),
	(16, 'steam:1100001345581d4', 2);
/*!40000 ALTER TABLE `playtime_final` ENABLE KEYS */;

-- Dumping structure for table fortis.portofoons
CREATE TABLE IF NOT EXISTS `portofoons` (
  `frequentie` double DEFAULT NULL,
  `naam` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.portofoons: ~0 rows (approximately)
DELETE FROM `portofoons`;
/*!40000 ALTER TABLE `portofoons` DISABLE KEYS */;
/*!40000 ALTER TABLE `portofoons` ENABLE KEYS */;

-- Dumping structure for table fortis.queue
CREATE TABLE IF NOT EXISTS `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.queue: ~0 rows (approximately)
DELETE FROM `queue`;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;

-- Dumping structure for table fortis.sneeuwpoppen
CREATE TABLE IF NOT EXISTS `sneeuwpoppen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gevonden` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`gevonden`)),
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`coords`)),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.sneeuwpoppen: ~0 rows (approximately)
DELETE FROM `sneeuwpoppen`;
/*!40000 ALTER TABLE `sneeuwpoppen` DISABLE KEYS */;
/*!40000 ALTER TABLE `sneeuwpoppen` ENABLE KEYS */;

-- Dumping structure for table fortis.stashitems
CREATE TABLE IF NOT EXISTS `stashitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15024 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.stashitems: ~0 rows (approximately)
DELETE FROM `stashitems`;
/*!40000 ALTER TABLE `stashitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `stashitems` ENABLE KEYS */;

-- Dumping structure for table fortis.stashitemsnew
CREATE TABLE IF NOT EXISTS `stashitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stash` (`stash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.stashitemsnew: ~0 rows (approximately)
DELETE FROM `stashitemsnew`;
/*!40000 ALTER TABLE `stashitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `stashitemsnew` ENABLE KEYS */;

-- Dumping structure for table fortis.tablet
CREATE TABLE IF NOT EXISTS `tablet` (
  `citizenid` varchar(50) DEFAULT NULL,
  `token` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.tablet: ~0 rows (approximately)
DELETE FROM `tablet`;
/*!40000 ALTER TABLE `tablet` DISABLE KEYS */;
/*!40000 ALTER TABLE `tablet` ENABLE KEYS */;

-- Dumping structure for table fortis.tattoos
CREATE TABLE IF NOT EXISTS `tattoos` (
  `citizenid` varchar(50) DEFAULT NULL,
  `tattoos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tattoos`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.tattoos: ~0 rows (approximately)
DELETE FROM `tattoos`;
/*!40000 ALTER TABLE `tattoos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tattoos` ENABLE KEYS */;

-- Dumping structure for table fortis.trunkitems
CREATE TABLE IF NOT EXISTS `trunkitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=633 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.trunkitems: ~0 rows (approximately)
DELETE FROM `trunkitems`;
/*!40000 ALTER TABLE `trunkitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitems` ENABLE KEYS */;

-- Dumping structure for table fortis.trunkitemsnew
CREATE TABLE IF NOT EXISTS `trunkitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=1127 DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.trunkitemsnew: ~0 rows (approximately)
DELETE FROM `trunkitemsnew`;
/*!40000 ALTER TABLE `trunkitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitemsnew` ENABLE KEYS */;

-- Dumping structure for table fortis.vissen
CREATE TABLE IF NOT EXISTS `vissen` (
  `steam` varchar(50) DEFAULT NULL,
  `plek` varchar(50) DEFAULT NULL,
  `positie` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fortis.vissen: ~0 rows (approximately)
DELETE FROM `vissen`;
/*!40000 ALTER TABLE `vissen` DISABLE KEYS */;
/*!40000 ALTER TABLE `vissen` ENABLE KEYS */;

-- Dumping structure for table fortis.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`steam`),
  UNIQUE KEY `identifier` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table fortis.whitelist: ~0 rows (approximately)
DELETE FROM `whitelist`;
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;


-- Dumping database structure for meos
CREATE DATABASE IF NOT EXISTS `meos` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `meos`;

-- Dumping structure for table meos.laws
CREATE TABLE IF NOT EXISTS `laws` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `fine` int(11) NOT NULL DEFAULT 0,
  `months` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=latin1;

-- Dumping data for table meos.laws: ~107 rows (approximately)
DELETE FROM `laws`;
/*!40000 ALTER TABLE `laws` DISABLE KEYS */;
INSERT INTO `laws` (`id`, `name`, `description`, `fine`, `months`) VALUES
	(27, 'R602 - Het negeren van een roodverkeerlicht', 'Niet stoppen bij rood verkeerslicht, ', 350, 0),
	(28, 'R628b - Niet opvolgen stopteken wout', 'Het negeren stop teken, Bij verkeers controle en bij vordering ', 1000, 0),
	(29, 'D505 - Baldadigheid', 'Op de openbare weg of op een voor publiek toegankelijke plaats tegen goederen of personen baldadigheid plegen\r\nstraatschenderij; waaruit bleek dit; feitelijke baldadigheid beschrijven.', 830, 0),
	(30, 'F116a - Inbrekerswerktuig', 'Het is verboden op de weg of in de nabijheid van winkels te vervoeren of bij zich te hebben een voorwerp dat er kennelijk toe is uitgerust om het plegen van (winkel)diefstal te vergemakkelijken', 500, 0),
	(31, 'D517 - Identiteitsbewijs', 'Niet voldoen aan de verplichting om een identiteitsbewijs ter inzage aan te bieden feiten en omstandigheden vermelden waarom vordering redelijkerwijze noodzakelijk werd geacht.', 750, 0),
	(32, 'Administratiekosten', 'Administratiekosten die wettelijk zijn berekend. die bij elke boete bij geteld word', 12, 0),
	(34, 'K150c - Niet op eerste vordering behoorlijk het rijbewijs ter inzage afgeven', 'Niet op eerste vordering behoorlijk het rijbewijs ter inzage afgeven', 750, 0),
	(35, 'Artikel 266sr - Belediging ambtenaar in functie', 'Belediging van Ambtenaar in Functie', 4350, 3),
	(36, '2e categorie', 'Boete van 2e categorie', 4350, 0),
	(37, '1e categorie', 'Boete van 1e categorie', 435, 0),
	(38, '3e categorie', 'Boete van de 3e categorie', 8700, 0),
	(39, '4e categorie', 'Boete van 4e categorie', 14500, 0),
	(40, '5e categorie', 'Boete van 5e Categorie', 20000, 0),
	(41, '6e categorie', 'Boete van 6e categorie  - Alleen in overleg geven met korpsleiding', 30000, 0),
	(43, 'VA 005 - Snelheidsoverschrijding 5 km/h', 'Overschrijding van maximum snelheid', 187, 0),
	(44, 'VA 010 - Snelheidsoverschrijding 10 km/h', 'Overschrijding van maximum snelheid', 210, 0),
	(46, 'VA 015 - Snelheidsoverschrijding 15/20 km/h', 'Overschrijding van maximum snelheid', 310, 0),
	(47, 'VA 025 - Snelheidsoverschrijding 25/30 km/h', 'Overschrijding van maximum snelheid', 400, 0),
	(48, 'VA 040 - Snelheidsoverschrijding 30/40 km/h', 'Overschrijding van maximum snelheid', 675, 0),
	(49, 'VA 050 - Snelheidsoverschrijding 50 km/h', 'Overschrijding van maximum snelheid', 1000, 0),
	(50, 'VA 060 - Snelheidsoverschrijding 60/70 km/h', 'Overschrijding van maximum snelheid', 1150, 0),
	(51, 'VA 080 - Snelheidsoverschrijding 70 /90 km/h', 'Overschrijding van maximum snelheid', 1700, 0),
	(52, 'VA 100 - Snelheidsoverschrijding 100 km/h', 'Overschrijding van maximum snelheid', 2500, 0),
	(53, 'Artikel 5 - Wegenverkeerswet', 'Het is een ieder verboden zich zodanig te gedragen dat gevaar op de weg wordt veroorzaakt of kan worden veroorzaakt of dat het verkeer op de weg wordt gehinderd of kan worden gehinderd. 3 maanden voorwaardelijk', 4500, 0),
	(55, 'Artikel 184 - Niet voldoen aan een bevel of vordering', 'Hij die opzettelijk niet voldoet aan een bevel of een vordering, krachtens wettelijk voorschrift gedaan door een ambtenaar met de uitoefening van enig toezicht belast of door een ambtenaar belast met of bevoegd verklaard tot het opsporen of onderzoeken van strafbare feiten, alsmede hij die opzettelijk enige handeling, door een van die ambtenaren ondernomen ter uitvoering van enig wettelijk voorschrift, belet, belemmert of verijdelt.', 4350, 5),
	(57, 'Artikel 426ter - Belemmeren hulpverlener', 'Hij die wederrechtelijk een hulpverlener gedurende de uitoefening van zijn beroep in zijn vrijheid van beweging belemmert of met een of meer anderen zich aan hem tegen zijn uitdrukkelijk verklaarde wil blijft opdringen of hem op hinderlijke wijze blijft volgen wordt gestraft met hechtenis van ten hoogste drie maanden of geldboete van de derde categorie.', 8700, 18),
	(58, 'Artikel 196 - Onrechtmatig voordoen als wout ambt.', 'Hij die in het openbaar kledingstukken of opzichtige onderscheidingstekens draagt of voert, welke uitdrukking zijn van een bepaald staatkundig streven, wordt gestraft met hechtenis van ten hoogste twaalf dagen of geldboete van de tweede categorie.', 4500, 15),
	(59, 'Artikel 142 - Misbruik noodnummer', 'Valse meldingen maken - onnodig gebruik maken van 112 nummer', 7500, 10),
	(60, 'Artikel 48 - Medeplichtigen mishandeling', 'Vechten, na aangifte kan straf gegeven worden', 1250, 5),
	(61, 'Artikel 26 - WWM CAT. II&III', 'Vuur handwapens & Munitie', 5000, 12),
	(62, 'Artikel 27 - WWM Semi,full automatische ', 'Semi wapens en full automatisch wapens.', 10000, 40),
	(63, 'Artikel 13 - WWM cat I', 'Steekwapens en slagwapens (Vrijwillig afstaan geen celstraf van 10 maand)', 2275, 0),
	(64, 'Artikel 461 - Verboden toegang', 'Zonder daartoe gerechtigd te zijn zich bevinden op eens anders grond, waarvan de toegang op blijkbare wijze was\r\nverboden op welke blijkbare wijze was de toegang verboden; waar bevond verdachte zich; niet op kenteken.\r\n', 2500, 5),
	(65, 'Artikel 310 - Eenvoudige diefstal', 'Het ontnemen van goederen uit bijvoorbeeld, Huis,winkel,persoon (bij nacht is huis art.311)', 1750, 15),
	(66, 'Artikel 311 - Gekwalificeerde diefstal', 'diefstal gedurende de voor de nachtrust bestemde tijd, in een woning of op een besloten erf waarop een woning staat, door iemand die zich aldaar buiten weten of tegen de wil van de rechthebbende bevindt;\r\ndiefstal door twee of meer verenigde personen;\r\ndiefstal waarbij de schuldige zich de toegang tot de plaats van het misdrijf heeft verschaft of het weg te nemen goed onder zijn bereik heeft gebracht door middel van braak, verbreking of inklimming, van valse sleutels, van een valse order of een vals kostuum;', 2500, 20),
	(67, 'Artikel 312 - Diefstal met geweld', 'Winkel & Huisinbraak', 4000, 30),
	(68, 'Artikel 255 - Verlating van hulpbehoevenden', 'Hij die opzettelijk iemand tot wiens onderhoud, verpleging of verzorging hij krachtens wet of overeenkomst verplicht is, in een hulpeloze toestand brengt of laat, wordt gestraft met gevangenisstraf van ten hoogste twee jaren of geldboete van de vierde categorie.', 4350, 48),
	(71, 'Artikel 177 - Omkoping', 'Hij die een ambtenaar een gift of belofte doet dan wel een dienst verleent of aanbiedt met het oogmerk om hem te bewegen in zijn bediening, in strijd met zijn plicht, iets te doen of na te laten;\r\n2hij die een ambtenaar een gift of belofte doet dan wel een dienst verleent of aanbiedt ten gevolge of naar aanleiding van hetgeen door deze in zijn huidige of vroegere bediening, in strijd met zijn plicht, is gedaan of nagelaten.', 10000, 20),
	(72, 'Artikel 282 - Gijzeling/ontvoeren', 'Hij die opzettelijk iemand wederrechtelijk van de vrijheid berooft of beroofd houdt,\r\n\r\n', 4350, 25),
	(73, 'Artikel 302 - Zware mishandeling', 'Hij die aan een ander opzettelijk zwaar lichamelijk letsel toebrengt maar waardoor persoon nog wel zelfstandig na ziekenhuis kan.\r\nZoals aanrijden,of steek/slagwapen,nekslag', 6000, 25),
	(74, 'Artikel 48 - Medeplichtigen Moord', 'Hij die opzettelijk een ander van het leven berooft, wordt, als schuldig aan doodslag', 11000, 40),
	(75, 'Artikel 287 - Doodslag/Moord', 'Hij die opzettelijk een ander van het leven berooft, wordt, als schuldig aan doodslag', 21750, 60),
	(76, 'Artikel 289 - Moord voorbedachten rade', 'Hij die opzettelijk en met voorbedachten rade een ander van het leven berooft,\r\n(Doel bewust iemand vermoorden)', 30000, 80),
	(78, 'R315b - Foutief parkeren', 'Als bestuurder een voertuig parkeren op een andere plaats dan daarvoor bestemd is. ', 780, 0),
	(80, 'Artikel 11 Opw - SOFT DRUGS (Vanaf 6 tot 10)', 'Op zak hebben van hard drugs zoals (Wiet, Joint)', 2000, 10),
	(81, 'Artikel 11 Opw - SOFT DRUGS (Vanaf 11 tot 20)', 'Op zak hebben van hard drugs zoals (Wiet, Joint)', 4000, 30),
	(82, 'Artikel 11 Opw -SOFT DRUGS (Vanaf 20+)', 'Op zak hebben van hard drugs zoals (Wiet, Joint)', 6500, 35),
	(83, 'Artikel 11 Opw - Softdrugs Bricks', 'Verhandelen van wiet bricks', 1500, 15),
	(84, 'Artikel 10 Opw -HARD DRUGS (Vanaf 2 tot 10)', 'Op zak hebben van hard drugs zoals (Oxy,Coke, Meth)', 3000, 35),
	(85, 'Artikel 10 Opw - HARD DRUGS (Vanaf 11 tot 20)', 'Op zak hebben van hard drugs zoals (Oxy,Coke, Meth)', 6000, 40),
	(86, 'Artikel 10 Opw - Hard drugs (Vanaf 20+)', 'Op zak hebben van hard drugs zoals (Oxy,Coke, Meth)', 10000, 60),
	(89, 'Artikel 447e - Niet meewerken identificatieplicht', 'Niet meewerken aan identificatieplicht, zoals vingerafdrukken,dna,bloed,NAW gegevens,foto', 5000, 12),
	(91, 'Art. 180 Verzet van arrestatie', 'Het verzetten bij een arrestatie. in cellencomplex/ziekenhuis', 1500, 0),
	(94, 'Eenvoudige mishandeling', 'Vechten, na aangifte kan straf gegeven worden', 2500, 5),
	(95, 'Verstoring openbare orde ', 'duwen, trekken, schelden,vechten,samenscholing etc.', 3200, 5),
	(97, 'Art.317 - Afpersing en afdreiging', 'Hij die, met het oogmerk door geweld of bedreiging met geweld iemand dwingt hetzij tot de afgifte van enig goederen dat geheel of ten dele aan deze of aan een derde toebehoort, hetzij tot het aangaan van een schuld of het teniet doen van een inschuld, hetzij tot het ter beschikking stellen van gegevens, wordt, als schuldig aan afpersing', 8700, 30),
	(98, 'Artikel 188 - Valse aangifte', 'Hij die aangifte of klacht doet dat een strafbaar feit gepleegd is, wetende dat het niet gepleegd is, wordt gestraft met gevangenisstraf van ten hoogste een jaar of geldboete van de derde categorie. ', 4005, 24),
	(99, 'Artikel 307 - Dood door schuld', 'Bij roekeloos rijden waar een slachtoffer is gevallen, ', 8700, 48),
	(100, 'Artikel 138 - Huisvredebreuk', 'Hij die in de woning of het besloten lokaal of erf, bij een ander in gebruik, wederrechtelijk binnendringt of, wederrechtelijk aldaar vertoevende, zich niet op de vordering van of vanwege de rechthebbende aanstonds verwijdert.\r\n\r\nHij die zich de toegang heeft verschaft door middel van braak of inklimming, van valse sleutels, van een valse order of een vals kostuum, of die, zonder voorkennis van de rechthebbende en anders dan ten gevolge van vergissing binnengekomen, aldaar wordt aangetroffen in de voor de nachtrust bestemde tijd, wordt geacht te zijn binnengedrongen.', 4900, 24),
	(103, 'Artikel 1 - Gezichtsbedekkende kleding', 'In openbaar masker dragen, en na eerste vordering niet afdoen.', 750, 0),
	(104, 'Artikel 350 - Vernieling', 'Hij die opzettelijk en wederrechtelijk enig goed dat geheel of ten dele aan een ander toebehoort, vernielt, beschadigt, onbruikbaar maakt of wegmaakt, wordt gestraft met gevangenisstraf van ten hoogste twee jaren of geldboete van de derde categorie.', 2500, 5),
	(105, 'Artikel 285 - Bedreiging', 'met enig misdrijf tegen het leven gericht,bepaalde uitingen zoals ik maak je kapot,of ik smijt je van de berg', 5000, 15),
	(108, 'Heterdaad grinden.', 'Zei die heterdaad gepakt zijn op het grinden van materialen en/of geld ontvangen deze boete.', 2000, 10),
	(109, 'Heterdaad janken', 'Hij/zij die heterdaad gepakt zijn of alleen maar zoutig zijn kunnen deze boete ontvangen voor hun gedrag.', 3500, 10),
	(110, 'R426a - Rijden zonder verlichting', 'als bestuurder van een motorvoertuig, bromfietser, snorfietser of als bestuurder van een gehandicaptenvoertuig rijden terwijl niet gelijktijdig met het groot licht, het dimlicht, het stadslicht of het mistlicht, het achterlicht brandt bij nacht, binnen de bebouwde kom.', 600, 0),
	(112, 'Terroristische bommelding', 'Deze straf kan gegeven worden, voor Heterdaad betrappen van plaatsen van Bommen in onder andere autos, etc etc, tevens ook voor het dragen voor bomgordel, explosieven. Meer info volgt.', 30000, 120),
	(115, 'Artikel 6 Schuldig aan verkeersongeluk', 'Het is een ieder die aan het verkeer deelneemt verboden zich zodanig te gedragen dat een aan zijn schuld te wijten verkeersongeval plaatsvindt waardoor een ander wordt gedood of waardoor een ander zwaar lichamelijk letsel wordt toegebracht of zodanig lichamelijk letsel dat daaruit tijdelijke ziekte of verhindering in de uitoefening van de normale bezigheden ontstaat.', 3000, 20),
	(116, 'Artikel 7 Plaatsdelict verlaten', 'Het is degene die bij een verkeersongeval is betrokken of door wiens gedraging een verkeersongeval is veroorzaakt, verboden de plaats van het ongeval te verlaten.', 5000, 15),
	(117, 'Artikel 8 Rijden onder invloed', 'Het is een ieder verboden een voertuig te besturen, als bestuurder te doen besturen of als begeleider op te treden, terwijl hij verkeert onder zodanige invloed van een stof, waarvan hij weet of redelijkerwijs moet weten, dat het gebruik daarvan - al dan niet in combinatie met het gebruik van een andere stof - de rijvaardigheid kan verminderen, dat hij niet tot behoorlijk besturen of tot behoorlijk te begeleiden in staat moet worden geacht', 4500, 15),
	(119, 'Artikel 36 Geen kenteken hebben.', 'kentekenplichtig voertuig van persoon heeft geen kenteken.', 2000, 0),
	(121, 'Artikel 140 Deelneming criminele oragnisatie', 'Deelneming aan een organisatie die tot oogmerk heeft het plegen van misdrijven, wordt gestraft met gevangenisstraf van ten hoogste zes jaren of geldboete van de vijfde categorie.', 4500, 10),
	(122, 'Artikel 149 Grafsteen opzettelijk vernielen', 'Hij die opzettelijk een graf schendt of enig op een begraafplaats opgericht gedenkteken opzettelijk en wederrechtelijk vernielt of beschadigt, wordt gestraft met gevangenisstraf van ten hoogste een jaar of geldboete van de derde categorie.', 1500, 0),
	(124, 'Artikel 157 Brandstichting', 'Hij die opzettelijk brand sticht of een ontploffing teweegbrengt word gestraft met 15 maanden en een geld boete van 4500', 4500, 15),
	(125, 'Artikel 168 Voertuig onbruikbaar maken', 'Hij die enig vaartuig, voertuig of luchtvaartuig opzettelijk en wederrechtelijk doet zinken, stranden of verongelukken, vernielt, onbruikbaar maakt of beschadigt.', 6500, 0),
	(129, 'Artikel 420 - Witwassen', 'Witwassen dat enkel bestaat uit het verwerven of voorhanden hebben van een voorwerp dat onmiddellijk afkomstig is uit enig eigen misdrijf wordt als eenvoudig witwassen.', 4000, 0),
	(131, 'Artikel 426 Openbaar dronkenschap', 'Dronken op openbare weg, hinder veroorzaken  (7 maand in cel HB)', 3500, 7),
	(133, 'Artikel 5.2.65 Neonlicht voeren', 'Personenauto\'s met meer licht dan toegestaan. (Neon onder de auto, andere kleur koplampen)', 1500, 0),
	(134, 'F120a - Klimmen en klauteren', 'Klimmen of zich bevinden op een beeld, monument, overkapping, constructie, openbare toiletgelegenheid, voertuig, hek, heining of andere afsluiting, verkeersmeubilair of daarvoor niet bestemd straatmeubilair waarop?', 95, 3),
	(135, 'R395 - Gevaar of hinder veroorzaken met stilstaand voertuig', 'Een voertuig op een zodanige wijze laten staan waardoor op de weg gevaar wordt/kan worden veroorzaakt, dan wel het verkeer wordt/kan worden gehinderd gevaar; situatie omschrijven; cat. 4 uitsluitend gehandicaptenvoertuig\\r\\nmet motor.', 1250, 0),
	(136, 'Afsleepkosten ', 'Als je een auto moet laten wegslepen.', 500, 0),
	(137, 'Artikel 367 - Helpen bij ontsnapping', 'bevrijding of zelfbevrijding aan zijn schuld te wijten is, wordt hij gestraft met hechtenis.', 4350, 20),
	(139, 'F173a - Handelen in verdovende middelen', 'Zich op een openbare plaats ophouden met het kennelijke doel om middelen als bedoeld in artikel 2 en 3 van de Opiumwet of daarop gelijkende waar, al dan niet tegen betaling af te leveren, aan te bieden of te verwerven, daarbij behulpzaam te zijn of daarin te bemiddelen waaruit kon worden aangenomen dat werd gehandeld.', 4150, 24),
	(140, 'Artikel 216 - Heling', 'Hij die een goed verwerft, voorhanden heeft of overdraagt, dan wel een persoonlijk recht op of een zakelijk recht ten aanzien van een goed vestigt of overdraagt, terwijl hij ten tijde van de verwerving of het voorhanden krijgen van het goed dan wel het vestigen van het recht wist dat het een door misdrijf verkregen goed betrof.', 4150, 20),
	(142, 'K055 - Rijden zonder geldig rijbewijs', 'artikel 107, lid 1 en feitcode K055\\r\\nRijden zonder rijbewijs. Wanneer men een motorvoertuig bestuurt zonder rijbewijs is men in overtreding', 3500, 0),
	(144, 'D515 - Valse identiteit opgeven', 'opgeven van een valse naam, voornaam, geboortedatum, geboorteplaats, adres of woon- of verblijfplaats', 3900, 5),
	(145, 'F121b - Op openbare weg met aangebroken fles/blik alcohol', 'aangebroken flessen, blikjes e.d. met alcoholhoudende drank bij zich hebben op een openbare plaats in aangew. geb.', 95, 0),
	(147, 'H205 - Overlast veroorzaken voor omgeving d.m.v. toestellen of geluidsapparatuur', 'Veroorzaken van geluidhinder voor een omwonende of de omgeving door/met toe- stellen/(geluids)apparaten/handelingen', 1250, 0),
	(148, 'F250 - Met een voertuig rijden door park / plantsoen', 'zonder ontheffing rijden/bevinden met vo ertuig/paard in publiektoegankelijk park natuurgebied/plantsoen/recreatieterrein', 1400, 0),
	(150, 'CITES - Koraal 1 t/m 10 stuks', 'Het in bezit zijn van "Vochtig" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald', 800, 0),
	(151, 'CITES - Koraal 11 t/m 25 stuks', 'Het in bezit zijn van "Vochtig" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 1400, 0),
	(152, 'CITES - Koraal 26 t/m 50 stuks', 'Het in bezit zijn van "Vochtig" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 2000, 0),
	(153, 'CITES - Koraal 51 t/m 75 stuks', 'Het in bezit zijn van "Vochtig" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 3000, 0),
	(154, 'CITES - Koraal 76 t/m 100 stuks', 'Het in bezit zijn van "Vochtig" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 4500, 0),
	(155, 'CITES - Koraal 101 t/m 125 stuks', 'Het in bezit zijn van "Vochtig" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 6000, 0),
	(156, 'CITES - Koraal 125+', 'Het in bezit zijn van "Vochtig" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 8000, 10),
	(157, 'R551a - Eenrichtingsweg overige wegen', 'Handelen in strijd met geslotenverklaring, als bestuurder van een motorvoertuig, bromfiets of snorfiets op autoweg of autosnelweg (spookrijden)', 1400, 0),
	(159, 'Artikel 11- WVW Niet APK waardig', 'Niet APK waardig voertuig, Het is verboden opzettelijk wederrechtelijk een aan een ander toebehorend motorrijtuig op de weg te gebruiken.', 1000, 0),
	(163, 'Artikel 312 - Kleine bank + Juwelier', 'Diefstal met geweld bij Kleine bank en Juwelier', 8000, 30),
	(165, 'Artikel 312 - Pacific Bank', 'Diefstal met geweldpleging bij grote bank', 15000, 50),
	(168, 'H107 - Voertuigwrak op de weg laten staan', 'een voertuigwrak parkeren op de weg', 750, 0),
	(169, 'Artikel 48 - Medeplichtigen Zware mishandeling', 'Hij die medeplicht is  aan een ander opzettelijk zwaar lichamelijk letsel toebrengt maar waardoor persoon nog wel zelfstandig na ziekenhuis kan.\r\nZoals aanrijden,of steek/slagwapen,nekslag', 3500, 15),
	(170, 'Artikel 48 - Medeplichtigen Afpersing en afdreiging', 'Hij die mee doet aan, met het oogmerk om zich of een ander wederrechtelijk te bevoordelen, door geweld of bedreiging met geweld iemand dwingt hetzij tot de afgifte van enig goed dat geheel of ten dele aan deze of aan een derde toebehoort, hetzij tot het aangaan van een schuld of het teniet doen van een inschuld, hetzij tot het ter beschikking stellen van gegevens, wordt, als schuldig aan afpersing.', 4300, 15),
	(171, 'Artikel 48 - Medeplichtig Gezijzeling/ontvoering', 'Hij die mede opzettelijk iemand wederrechtelijk van de vrijheid berooft of beroofd houdt.', 2100, 12),
	(173, 'Artikel 288 - Poging tot doodslag/moord', 'Iemand proberen van het leven te beroven, maar mislukt ', 11000, 30),
	(175, 'Artikel 48 - Medeplichtig Tot poging doodslag/moord', 'Iemand proberen van het leven te beroven, maar mislukt ', 6000, 15),
	(176, 'Artikel 48 - Medeplichting Moord voorbedachten rade', 'Hij die medeplichtig is aan opzettelijk en met voorbedachten rade een ander van het leven berooft,\r\n(Doel bewust iemand vermoorden)', 15000, 55),
	(177, 'Artikel 161ter - (Koperdiefstal)', 'Titel VII. Misdrijven waardoor de algemene veiligheid van personen of goederen wordt in gevaar gebracht\r\nArtikel 161ter\r\nHij aan wiens schuld te wijten is, dat enig elektriciteitswerk wordt vernield, beschadigd, of onbruikbaar gemaakt, dat stoornis in de gang of in de werking van zodanig werk ontstaat, of dat een ten opzichte van zodanig werk genomen veiligheidsmaatregel wordt verijdeld', 1500, 12);
/*!40000 ALTER TABLE `laws` ENABLE KEYS */;

-- Dumping structure for table meos.profiles
CREATE TABLE IF NOT EXISTS `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'https://i.imgur.com/tdi3NGa.png',
  `fingerprint` varchar(255) DEFAULT NULL,
  `dnacode` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `lastsearch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table meos.profiles: ~1 rows (approximately)
DELETE FROM `profiles`;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` (`id`, `citizenid`, `fullname`, `avatar`, `fingerprint`, `dnacode`, `note`, `lastsearch`) VALUES
	(1, 'QBJ37951', 't', 'Linkje imgur toid', 't', 't', '', 1660834283),
	(2, 'ZAC49531', 'Test account', 'Linkje imgur oid', '', '', '', 1664632613);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;

-- Dumping structure for table meos.reports
CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `profileid` int(11) DEFAULT NULL,
  `report` text NOT NULL,
  `laws` text DEFAULT NULL,
  `created` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table meos.reports: ~1 rows (approximately)
DELETE FROM `reports`;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` (`id`, `title`, `author`, `profileid`, `report`, `laws`, `created`) VALUES
	(1, 'test report', 'Admin', 2, '<p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><img src="./assets/images/pv_logo.png" style="width: 205px; display: inline-block; vertical-align: bottom; margin-right: 5px; margin-left: 5px; float: none; max-width: calc(100% - 10px); text-align: center; border-style: none; box-sizing: border-box;" fr-original-style="width: 205px; display: inline-block; vertical-align: bottom; margin-right: 5px; margin-left: 5px; float: none; max-width: calc(100% - 10px); text-align: center;" fr-original-class="fr-fic fr-draggable"></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">EENHEID LOS SANTOS</strong></span></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;">DISTRICT LS-Zuid</span></strong></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;">BASISTEAM MISSION ROW</span></strong></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></strong></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style="vertical-align: baseline;" style="vertical-align: baseline; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">M I N I - P R O C E S - V E R B A A L</strong></span></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style="background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;" style="background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">beschikking</strong></span></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;">Ik, verbalisant, Admin dmin, Agent van wout Eenheid Los Santos, verklaar het volgende.</p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;">Op 06-02-2022, rond <span fr-original-style="color: rgb(235, 107, 86);" style="color: rgb(235, 107, 86); box-sizing: border-box;">TIME</span>, bevond ik mij in uniform gekleed en met algemene wouttaak belast op de openbare weg.&nbsp;</p><p fr-original-style="line-height: 1.2;" style="line-height: 1.2; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;">BEVINDINGEN</p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;">Locatie:<br fr-original-style="" style="box-sizing: border-box;">Overtreding:<br fr-original-style="" style="box-sizing: border-box;">finebedrag:<br fr-original-style="" style="box-sizing: border-box;">Verklaring:&nbsp;</p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><em fr-original-style="" style="box-sizing: border-box;"><span fr-original-style="font-size: 10px;" style="font-size: 10px; box-sizing: border-box;">In geval van snelheid</span></em><br fr-original-style="" style="box-sizing: border-box;">Gemeten snelheid:<br fr-original-style="" style="box-sizing: border-box;">Toegestane snelheid:<br fr-original-style="" style="box-sizing: border-box;">Correctie: - 10%<br fr-original-style="" style="box-sizing: border-box;">Uiteindelijke snelheid:&nbsp;</p>', '[37,36,36,36]', 1664633526),
	(2, 'test ZAC49531', 'Admin', 2, '<p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><img src="./assets/images/pv_logo.png" style="width: 205px; display: inline-block; vertical-align: bottom; margin-right: 5px; margin-left: 5px; float: none; max-width: calc(100% - 10px); text-align: center; border-style: none; box-sizing: border-box;" fr-original-style="width: 205px; display: inline-block; vertical-align: bottom; margin-right: 5px; margin-left: 5px; float: none; max-width: calc(100% - 10px); text-align: center;" fr-original-class="fr-fic fr-draggable"></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">EENHEID LOS SANTOS</strong></span></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;">DISTRICT LS-Zuid</span></strong></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;">BASISTEAM MISSION ROW</span></strong></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style=" vertical-align: baseline;" style="vertical-align: baseline; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">P R O C E S - V E R B A A L</strong></span></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style=" background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;" style="background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">bewijsmateriaal</strong></span></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;">Ik, verbalisant, Admin dmin, Agent van wout Eenheid Los Santos, verklaar het volgende.</p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style=" line-height: 1.2;" style="line-height: 1.2; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;">BEVINDINGEN</p><p fr-original-style=" line-height: 1.2;" style="line-height: 1.2; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;" style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; float: none; display: inline !important; box-sizing: border-box;">Adres Bedrijf/Winkel:&nbsp;</span><br style="box-sizing: border-box; color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;" fr-original-style="box-sizing: border-box; color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><span fr-original-style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;" style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; float: none; display: inline !important; box-sizing: border-box;">Datum/tijd:&nbsp;</span><br style="box-sizing: border-box; color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;" fr-original-style="box-sizing: border-box; color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><span fr-original-style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;" style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; float: none; display: inline !important; box-sizing: border-box;">Bewijs</span>:&nbsp;</p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p>', '[37,37,36,36,36]', 1664633631),
	(3, 'test ZAC49531', 'Admin', 2, '<p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><img src="./assets/images/pv_logo.png" style="width: 205px; display: inline-block; vertical-align: bottom; margin-right: 5px; margin-left: 5px; float: none; max-width: calc(100% - 10px); text-align: center; border-style: none; box-sizing: border-box;" fr-original-style="width: 205px; display: inline-block; vertical-align: bottom; margin-right: 5px; margin-left: 5px; float: none; max-width: calc(100% - 10px); text-align: center;" fr-original-class="fr-fic fr-draggable"></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">EENHEID LOS SANTOS</strong></span></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;">DISTRICT LS-Zuid</span></strong></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;"><span fr-original-style="font-size: 14px;" style="font-size: 14px; box-sizing: border-box;">BASISTEAM MISSION ROW</span></strong></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: left; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style=" vertical-align: baseline;" style="vertical-align: baseline; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">P R O C E S - V E R B A A L</strong></span></p><p dir="ltr" fr-original-style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt;" style="line-height: 1.38; text-align: center; margin-top: 0pt; margin-bottom: 0pt; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style=" background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;" style="background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap; box-sizing: border-box;"><strong fr-original-style="" style="font-weight: bolder; box-sizing: border-box;">bewijsmateriaal</strong></span></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;">Ik, verbalisant, Admin dmin, Agent van wout Eenheid Los Santos, verklaar het volgende.</p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style=" line-height: 1.2;" style="line-height: 1.2; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;">BEVINDINGEN</p><p fr-original-style=" line-height: 1.2;" style="line-height: 1.2; font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><span fr-original-style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;" style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; float: none; display: inline !important; box-sizing: border-box;">Adres Bedrijf/Winkel:&nbsp;</span><br style="box-sizing: border-box; color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;" fr-original-style="box-sizing: border-box; color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><span fr-original-style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;" style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; float: none; display: inline !important; box-sizing: border-box;">Datum/tijd:&nbsp;</span><br style="box-sizing: border-box; color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;" fr-original-style="box-sizing: border-box; color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;"><span fr-original-style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;" style="color: rgb(65, 65, 65); font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; float: none; display: inline !important; box-sizing: border-box;">Bewijs</span>:&nbsp;</p><p fr-original-style="" style="font-size: 0.875rem; font-weight: 300; box-sizing: border-box;"><br fr-original-style="" style="box-sizing: border-box;"></p>', '[37,37,36,36,36]', 1664633717),
	(4, '12313', 'Admin', 2, '<p fr-original-style="" style="margin-top: 0px; margin-bottom: 0.2rem; font-size: 0.875rem; line-height: 150%; font-weight: 300; box-sizing: border-box;">adsa</p>', '[36,41,32]', 1664633729),
	(5, '12313', 'Admin', 2, '<p fr-original-style="" style="margin-top: 0px; margin-bottom: 0.2rem; font-size: 0.875rem; line-height: 150%; font-weight: 300; box-sizing: border-box;">adsa</p>', '[36,41,32]', 1664633744);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;

-- Dumping structure for table meos.servers
CREATE TABLE IF NOT EXISTS `servers` (
  `guid` int(11) NOT NULL AUTO_INCREMENT,
  `server_name` varchar(50) DEFAULT NULL,
  `db_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1',
  `db_pass` varchar(50) DEFAULT '',
  `db_port` int(11) NOT NULL DEFAULT 3306,
  `db_user` varchar(50) NOT NULL,
  `db_players` varchar(50) NOT NULL,
  `db_vehicles` varchar(50) NOT NULL,
  `db_houses` varchar(50) NOT NULL,
  `server_owner` int(11) NOT NULL,
  `server_features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT ' {"vehicles":0,"houses":0,"warrants":0,"bills":0}',
  UNIQUE KEY `guid` (`guid`),
  KEY `server_owner` (`server_owner`),
  CONSTRAINT `server_owner` FOREIGN KEY (`server_owner`) REFERENCES `server_owner` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table meos.servers: ~0 rows (approximately)
DELETE FROM `servers`;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;

-- Dumping structure for table meos.server_owner
CREATE TABLE IF NOT EXISTS `server_owner` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `newsletter` int(1) DEFAULT NULL,
  `lastlogged` datetime DEFAULT NULL,
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table meos.server_owner: ~2 rows (approximately)
DELETE FROM `server_owner`;
/*!40000 ALTER TABLE `server_owner` DISABLE KEYS */;
INSERT INTO `server_owner` (`uid`, `username`, `password`, `email`, `newsletter`, `lastlogged`) VALUES
	(1, NULL, '$2y$10$GhCJxefkKb6cUJxhOPs6cOG13HJD2Udr6QLWIwRULUN', 'test@test.nl', 1, NULL),
	(2, NULL, '$2y$10$AbajpiJUihLGfjfg.Pzfyumoa4Xr/Ge9VSOYXSMyDrL', 'test', 0, NULL);
/*!40000 ALTER TABLE `server_owner` ENABLE KEYS */;

-- Dumping structure for table meos.server_teams
CREATE TABLE IF NOT EXISTS `server_teams` (
  `tuid` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `leader` int(11) DEFAULT NULL,
  UNIQUE KEY `tuid` (`tuid`),
  KEY `team_owner` (`leader`),
  CONSTRAINT `team_owner` FOREIGN KEY (`leader`) REFERENCES `server_owner` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table meos.server_teams: ~0 rows (approximately)
DELETE FROM `server_teams`;
/*!40000 ALTER TABLE `server_teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_teams` ENABLE KEYS */;

-- Dumping structure for table meos.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `job` varchar(255) NOT NULL DEFAULT 'police',
  `role` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL,
  `last_login` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table meos.users: ~2 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`, `name`, `job`, `role`, `rank`, `last_login`) VALUES
	(1, 'Admin', '$2y$10$DpAfaQiRCS0A9vIlpGyHHO7D6NOuDqO2YhoA4UZcOq9u38ATSXoFy', 'Admin', 'police', 'admin', 'Agent', '2022-10-01'),
	(2, 'Bart O.', '$2y$10$fXZMDsHrmcW68ZSEYPS1J.URK7dWnNrtYi5DvpPnpel/mCsScAZfe', 'Bart Owens', 'police', 'user', 'Hoofdinspecteur', '2022-08-20');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table meos.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `plate` varchar(255) NOT NULL,
  `typevehicle` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'https://i.imgur.com/tdi3NGa.png',
  `note` text DEFAULT NULL,
  `lastsearch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table meos.vehicles: ~0 rows (approximately)
DELETE FROM `vehicles`;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Dumping structure for table meos.warrants
CREATE TABLE IF NOT EXISTS `warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table meos.warrants: ~0 rows (approximately)
DELETE FROM `warrants`;
/*!40000 ALTER TABLE `warrants` DISABLE KEYS */;
/*!40000 ALTER TABLE `warrants` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
