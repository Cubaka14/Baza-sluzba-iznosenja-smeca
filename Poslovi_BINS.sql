CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Poslovi_BEFORE_INSERT` BEFORE INSERT ON `Poslovi` FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255); 
    IF NOT EXISTS(SELECT z.tipSmeca
				  FROM Zahtev z
                  WHERE new.Zahtev_idZahtev = z.idZahtev
				  AND EXISTS(SELECT k.TipSmeca_idTipSmeca
							 FROM Koordinator k
							 WHERE k.TipSmeca_idTipSmeca = z.tipSmeca
							 AND k.Zaposleni_idZaposleni 
                             = new.Koordinator_Zaposleni_idZaposleni
                             AND z.Tipsmeca_idTipSmeca = k.Tipsmeca_idTipSmeca)
			 )
	THEN
		SET msg='Greska: Ovaj koordinator nije zaduzen za tu vrstu smeca!';
		SIGNAL sqlstate '45000' SET message_text= msg;
	END IF;
END