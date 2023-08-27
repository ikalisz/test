CREATE TABLE IF NOT EXISTS `marp_bank_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alici` varchar(50) NOT NULL,
  `gonderen` varchar(50) NOT NULL,
  `geleniban` varchar(50) NOT NULL,
  `gondereniban` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;