CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Vozac_BEFORE_UPDATE` BEFORE UPDATE ON `Vozac` FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255); 
    IF EXISTS(SELECT *
			  FROM Kamion k
              WHERE new.Kamion_idKamion = k.idKamion
					AND k.zauzet = 1
			 )
             AND new.zauzet = 1
	THEN
		SET msg='Greska: Kamion je zauzet!';
		SIGNAL sqlstate '45000' SET message_text= msg;
	END IF;
END