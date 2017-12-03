CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Zahtev_BEFORE_INSERT` BEFORE INSERT ON `Zahtev` FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);
    IF NOT EXISTS(SELECT *
				  FROM Dispecer d
                  WHERE d.Zaposleni_idZaposleni = new.Dispecer_Zaposleni_idZaposleni
                  AND d.aktivan = 0)
	THEN
		SET msg='Greska: Ovaj dispecer nije na duznosti!';
        SIGNAL sqlstate '45000' SET message_text= msg;
	END IF;
END