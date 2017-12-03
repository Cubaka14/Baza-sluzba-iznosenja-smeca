CREATE TRIGGER `mydb`.`Suspendovani_BEFORE_INSERT` BEFORE INSERT ON `Suspendovani` FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);
	IF EXISTS(SELECT * 
			  FROM Upravnik u
			  WHERE u.Zaposleni_idZaposleni = new.Zaposleni_idZaposleni) 
		AND NOT new.Zaposleni_idZaposleni = new.Upravnik_Zaposleni_idZaposleni
	THEN
		SET msg='Greska: Ne mozete upravnik suspendovati drugog upravnika';
		SIGNAL sqlstate '45000' SET message_text= msg;
	END IF;
        
END
