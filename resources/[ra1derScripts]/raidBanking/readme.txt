
                                               .         .
         .8.          8 8888                  ,8.       ,8.          8 8888888888    8888888888',8888'
        .888.         8 8888                 ,888.     ,888.         8 8888                 ,8',8888'
       :88888.        8 8888                .`8888.   .`8888.        8 8888                ,8',8888'
      . `88888.       8 8888               ,8.`8888. ,8.`8888.       8 8888               ,8',8888'
     .8. `88888.      8 8888              ,8'8.`8888,8^8.`8888.      8 888888888888      ,8',8888'
    .8`8. `88888.     8 8888             ,8' `8.`8888' `8.`8888.     8 8888             ,8',8888'
   .8' `8. `88888.    8 8888            ,8'   `8.`88'   `8.`8888.    8 8888            ,8',8888'
  .8'   `8. `88888.   8 8888           ,8'     `8.`'     `8.`8888.   8 8888           ,8',8888'
 .888888888. `88888.  8 8888          ,8'       `8        `8.`8888.  8 8888          ,8',8888'
.8'       `8. `88888. 8 888888888888 ,8'         `         `8.`8888. 8 888888888888 ,8',8888888888888


#######################################################################################################

* Compatible with QBCore!
* Low MS!
* Plug & Play!
* Open source.
* Easily convertible to ESX!


*** If you don't have QBCore.GetPlayerByIBAN() function, you can use this one:

QBCore.GetPlayerByIban = function(number)
    for src, player in pairs(QBCore.Players) do
        if QBCore.Players[src].PlayerData.charinfo.iban == number then
            return QBCore.Players[src]
        end
    end
    return nil
end


**** SQL file ->

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

#######################################################################################################
                                               .         .
         .8.          8 8888                  ,8.       ,8.          8 8888888888    8888888888',8888'
        .888.         8 8888                 ,888.     ,888.         8 8888                 ,8',8888'
       :88888.        8 8888                .`8888.   .`8888.        8 8888                ,8',8888'
      . `88888.       8 8888               ,8.`8888. ,8.`8888.       8 8888               ,8',8888'
     .8. `88888.      8 8888              ,8'8.`8888,8^8.`8888.      8 888888888888      ,8',8888'
    .8`8. `88888.     8 8888             ,8' `8.`8888' `8.`8888.     8 8888             ,8',8888'
   .8' `8. `88888.    8 8888            ,8'   `8.`88'   `8.`8888.    8 8888            ,8',8888'
  .8'   `8. `88888.   8 8888           ,8'     `8.`'     `8.`8888.   8 8888           ,8',8888'
 .888888888. `88888.  8 8888          ,8'       `8        `8.`8888.  8 8888          ,8',8888'
.8'       `8. `88888. 8 888888888888 ,8'         `         `8.`8888. 8 888888888888 ,8',8888888888888