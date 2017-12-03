CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Vozac_AFTER_UPDATE` AFTER UPDATE ON `Vozac` FOR EACH ROW
BEGIN
	IF new.zauzet <> old.zauzet
    THEN
		UPDATE Kamion k
		SET k.zauzet=new.zauzet
        WHERE new.Kamion_idKamion = k.idKamion;
	END IF;
END