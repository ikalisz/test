-- --------------------------------------------------------
-- Sunucu:                       localhost
-- Sunucu sürümü:                10.4.11-MariaDB - mariadb.org binary distribution
-- Sunucu İşletim Sistemi:       Win64
-- HeidiSQL Sürüm:               10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- tablo yapısı dökülüyor benimbirveritabanimvari̇smiondanbundantgi.tgiann_dna
CREATE TABLE IF NOT EXISTS `tgiann_dna` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tip` varchar(255) NOT NULL,
  `rastgeleid` varchar(255) NOT NULL,
  `isim` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- benimbirveritabanimvari̇smiondanbundantgi.tgiann_dna: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `tgiann_dna` DISABLE KEYS */;
INSERT INTO `tgiann_dna` (`id`, `tip`, `rastgeleid`, `isim`) VALUES
	(10, 'İnsan Kanı', '3-47-26-14', 'Gamil Aysever'),
	(11, 'Mermi Kovanı', '87-10-89-28', 'COMBAT PISTOL'),
	(12, 'İnsan Kanı', '82-7-88-66', 'Gamil Aysever'),
	(13, 'Mermi Kovanı', '63-50-17-82', 'COMBAT PISTOL'),
	(14, 'İnsan Kanı', '54-2-98-51', 'Gamil Aysever'),
	(15, 'Mermi Kovanı', '5-34-72-94', 'COMBAT PISTOL');
/*!40000 ALTER TABLE `tgiann_dna` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
