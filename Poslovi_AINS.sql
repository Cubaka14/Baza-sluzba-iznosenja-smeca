CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Vozac_AFTER_INSERT` AFTER INSERT ON `Vozac` FOR EACH ROW
BEGIN
	IF new.zauzet = 1
    THEN
		UPDATE Kamion k
		SET k.zauzet=new.zauzet
        WHERE new.Kamion_idKamion = k.idKamion;
	END IF;
END