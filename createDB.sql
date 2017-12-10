CREATE DATABASE IF NOT EXISTS `sluzbaIznosenjaSmeca` DEFAULT CHARACTER SET utf8 ;
USE `sluzbaIznosenjaSmeca` ;

-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Zaposleni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Zaposleni` (
  `idZaposleni` INT NOT NULL,
  `ime` VARCHAR(20) NOT NULL,
  `prezime` VARCHAR(20) NOT NULL,
  `plata` VARCHAR(45) NOT NULL,
  `brojRadnihDana` VARCHAR(45) NOT NULL,
  `brojSlobodnihDana` VARCHAR(45) NOT NULL,
  `datumZaposljavanja` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idZaposleni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Dispecer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Dispecer` (
  `Zaposleni_idZaposleni` INT NOT NULL,
  `aktivan` TINYINT(1) NOT NULL,
  PRIMARY KEY (`Zaposleni_idZaposleni`),
  CONSTRAINT `fk_Dispecer_Zaposleni`
    FOREIGN KEY (`Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Zaposleni` (`idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`TipSmeca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`TipSmeca` (
  `idTipSmeca` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `stepenOpasnosti` INT NOT NULL,
  PRIMARY KEY (`idTipSmeca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Koordinator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Koordinator` (
  `Zaposleni_idZaposleni` INT NOT NULL,
  `TipSmeca_idTipSmeca` INT NOT NULL,
  PRIMARY KEY (`Zaposleni_idZaposleni`),
  INDEX `fk_Koordinator_TipSmeca1_idx` (`TipSmeca_idTipSmeca` ASC),
  CONSTRAINT `fk_table1_Zaposleni1`
    FOREIGN KEY (`Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Zaposleni` (`idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Koordinator_TipSmeca1`
    FOREIGN KEY (`TipSmeca_idTipSmeca`)
    REFERENCES `sluzbaIznosenjaSmeca`.`TipSmeca` (`idTipSmeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Upravnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Upravnik` (
  `Zaposleni_idZaposleni` INT NOT NULL,
  PRIMARY KEY (`Zaposleni_idZaposleni`),
  CONSTRAINT `fk_Upravnik_Zaposleni1`
    FOREIGN KEY (`Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Zaposleni` (`idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Klijent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Klijent` (
  `idKlijent` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  `brojTelefona` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idKlijent`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Zahtev`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Zahtev` (
  `idZahtev` INT NOT NULL,
  `Dispecer_Zaposleni_idZaposleni` INT NULL,
  `tekstZahteva` VARCHAR(1000) NULL,
  `ocekivanDatumIznosenja` DATE NOT NULL,
  `odgovorDispecera` VARCHAR(1000) NULL,
  `Klijent_idKlijent` INT NOT NULL,
  `TipSmeca_idTipSmeca` INT NOT NULL,
  PRIMARY KEY (`idZahtev`, `Klijent_idKlijent`),
  INDEX `fk_Zahtev_Dispecer1_idx` (`Dispecer_Zaposleni_idZaposleni` ASC),
  INDEX `fk_Zahtev_Klijent1_idx` (`Klijent_idKlijent` ASC),
  INDEX `fk_Zahtev_TipSmeca1_idx` (`TipSmeca_idTipSmeca` ASC),
  CONSTRAINT `fk_Zahtev_Dispecer1`
    FOREIGN KEY (`Dispecer_Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Dispecer` (`Zaposleni_idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zahtev_Klijent1`
    FOREIGN KEY (`Klijent_idKlijent`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Klijent` (`idKlijent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zahtev_TipSmeca1`
    FOREIGN KEY (`TipSmeca_idTipSmeca`)
    REFERENCES `sluzbaIznosenjaSmeca`.`TipSmeca` (`idTipSmeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Poslovi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Poslovi` (
  `Dispecer_Zaposleni_idZaposleni` INT NOT NULL,
  `Koordinator_Zaposleni_idZaposleni` INT NOT NULL,
  `Zahtev_idZahtev` INT NOT NULL,
  `odgovorKoordinatora` VARCHAR(1000) NULL,
  `statusPosla` TINYINT(1) NOT NULL DEFAULT 0,
  `datumPlaniranogZavrsetka` VARCHAR(45) NOT NULL,
  INDEX `fk_Dispecer_has_Koordinator_Koordinator1_idx` (`Koordinator_Zaposleni_idZaposleni` ASC),
  INDEX `fk_Dispecer_has_Koordinator_Dispecer1_idx` (`Dispecer_Zaposleni_idZaposleni` ASC),
  INDEX `fk_Poslovi_Zahtev1_idx` (`Zahtev_idZahtev` ASC),
  PRIMARY KEY (`Zahtev_idZahtev`),
  CONSTRAINT `fk_Dispecer_has_Koordinator_Dispecer1`
    FOREIGN KEY (`Dispecer_Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Dispecer` (`Zaposleni_idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dispecer_has_Koordinator_Koordinator1`
    FOREIGN KEY (`Koordinator_Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Koordinator` (`Zaposleni_idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Poslovi_Zahtev1`
    FOREIGN KEY (`Zahtev_idZahtev`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Zahtev` (`idZahtev`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Radnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Radnik` (
  `Zaposleni_idZaposleni` INT NOT NULL,
  `Poslovi_Zahtev_idZahtev` INT NOT NULL,
  `zauzet` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Zaposleni_idZaposleni`),
  INDEX `fk_Radnik_Poslovi1_idx` (`Poslovi_Zahtev_idZahtev` ASC),
  CONSTRAINT `fk_Radnik_Zaposleni1`
    FOREIGN KEY (`Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Zaposleni` (`idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Radnik_Poslovi1`
    FOREIGN KEY (`Poslovi_Zahtev_idZahtev`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Poslovi` (`Zahtev_idZahtev`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Kamion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Kamion` (
  `idKamion` INT NOT NULL,
  `zauzet` TINYINT(1) NOT NULL DEFAULT 0,
  `TipSmeca_idTipSmeca` INT NOT NULL,
  PRIMARY KEY (`idKamion`),
  INDEX `fk_Kamion_TipSmeca1_idx` (`TipSmeca_idTipSmeca` ASC),
  CONSTRAINT `fk_Kamion_TipSmeca1`
    FOREIGN KEY (`TipSmeca_idTipSmeca`)
    REFERENCES `sluzbaIznosenjaSmeca`.`TipSmeca` (`idTipSmeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Suspendovani`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Suspendovani` (
  `Zaposleni_idZaposleni` INT NOT NULL,
  `Upravnik_Zaposleni_idZaposleni` INT NOT NULL,
  `razlog` VARCHAR(500) NULL,
  `datumSuspendovanja` DATE NOT NULL,
  `datumIstekaSusp` DATE NOT NULL,
  PRIMARY KEY (`Zaposleni_idZaposleni`, `Upravnik_Zaposleni_idZaposleni`),
  INDEX `fk_table1_Upravnik1_idx` (`Upravnik_Zaposleni_idZaposleni` ASC),
  CONSTRAINT `fk_table1_Zaposleni2`
    FOREIGN KEY (`Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Zaposleni` (`idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Upravnik1`
    FOREIGN KEY (`Upravnik_Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Upravnik` (`Zaposleni_idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sluzbaIznosenjaSmeca`.`Vozac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sluzbaIznosenjaSmeca`.`Vozac` (
  `Zaposleni_idZaposleni` INT NOT NULL,
  `godineIskustva` INT NULL,
  `Kamion_idKamion` INT NULL DEFAULT NULL,
  `zauzet` TINYINT(1) NOT NULL DEFAULT 0,
  `Poslovi_Zahtev_idZahtev` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Zaposleni_idZaposleni`),
  INDEX `fk_Vozac_Kamion1_idx` (`Kamion_idKamion` ASC),
  INDEX `fk_Vozac_Poslovi1_idx` (`Poslovi_Zahtev_idZahtev` ASC),
  CONSTRAINT `fk_Vozac_Zaposleni1`
    FOREIGN KEY (`Zaposleni_idZaposleni`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Zaposleni` (`idZaposleni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vozac_Kamion1`
    FOREIGN KEY (`Kamion_idKamion`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Kamion` (`idKamion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vozac_Poslovi1`
    FOREIGN KEY (`Poslovi_Zahtev_idZahtev`)
    REFERENCES `sluzbaIznosenjaSmeca`.`Poslovi` (`Zahtev_idZahtev`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `sluzbaIznosenjaSmeca`;

DELIMITER $$

USE `sluzbaIznosenjaSmeca`$$
DROP TRIGGER IF EXISTS `sluzbaIznosenjaSmeca`.`Zahtev_BEFORE_INSERT` $$
USE `sluzbaIznosenjaSmeca`$$
CREATE DEFINER = CURRENT_USER TRIGGER `sluzbaIznosenjaSmeca`.`Zahtev_BEFORE_INSERT` BEFORE INSERT ON `Zahtev` FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);
    IF NOT EXISTS(SELECT *
				  FROM Dispecer d
                  WHERE d.Zaposleni_idZaposleni = new.Dispecer_Zaposleni_idZaposleni
                  AND d.aktivan = 1)
	THEN
		SET msg='Greska: Ovaj dispecer nije na duznosti!';
        SIGNAL sqlstate '45000' SET message_text= msg;
	END IF;
END$$


USE `sluzbaIznosenjaSmeca`$$
DROP TRIGGER IF EXISTS `sluzbaIznosenjaSmeca`.`Zahtev_BEFORE_UPDATE` $$
USE `sluzbaIznosenjaSmeca`$$
CREATE DEFINER = CURRENT_USER TRIGGER `sluzbaIznosenjaSmeca`.`Zahtev_BEFORE_UPDATE` BEFORE UPDATE ON `Zahtev` FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);
    	IF NOT EXISTS(SELECT *
    			FROM Dispecer d
                  	WHERE d.Zaposleni_idZaposleni = new.Dispecer_Zaposleni_idZaposleni
                  	AND d.aktivan = 1)
	THEN
		SET msg='Greska: Ovaj dispecer nije na duznosti!';
        SIGNAL sqlstate '45000' SET message_text= msg;
	END IF;
END$$


USE `sluzbaIznosenjaSmeca`$$
DROP TRIGGER IF EXISTS `sluzbaIznosenjaSmeca`.`Suspendovani_BEFORE_INSERT` $$
USE `sluzbaIznosenjaSmeca`$$
CREATE TRIGGER `sluzbaIznosenjaSmeca`.`Suspendovani_BEFORE_INSERT` BEFORE INSERT ON `Suspendovani` FOR EACH ROW
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
        
END$$


USE `sluzbaIznosenjaSmeca`$$
DROP TRIGGER IF EXISTS `sluzbaIznosenjaSmeca`.`Vozac_BEFORE_INSERT` $$
USE `sluzbaIznosenjaSmeca`$$
CREATE DEFINER = CURRENT_USER TRIGGER `sluzbaIznosenjaSmeca`.`Vozac_BEFORE_INSERT` BEFORE INSERT ON `Vozac` FOR EACH ROW
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
END$$


USE `sluzbaIznosenjaSmeca`$$
DROP TRIGGER IF EXISTS `sluzbaIznosenjaSmeca`.`Vozac_AFTER_INSERT` $$
USE `sluzbaIznosenjaSmeca`$$
CREATE DEFINER = CURRENT_USER TRIGGER `sluzbaIznosenjaSmeca`.`Vozac_AFTER_INSERT` AFTER INSERT ON `Vozac` FOR EACH ROW
BEGIN
	IF new.zauzet = 1
    THEN
		UPDATE Kamion k
		SET k.zauzet=new.zauzet
        WHERE new.Kamion_idKamion = k.idKamion;
	END IF;
END$$


USE `sluzbaIznosenjaSmeca`$$
DROP TRIGGER IF EXISTS `sluzbaIznosenjaSmeca`.`Vozac_BEFORE_UPDATE` $$
USE `sluzbaIznosenjaSmeca`$$
CREATE DEFINER = CURRENT_USER TRIGGER `sluzbaIznosenjaSmeca`.`Vozac_BEFORE_UPDATE` BEFORE UPDATE ON `Vozac` FOR EACH ROW
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
END$$


USE `sluzbaIznosenjaSmeca`$$
DROP TRIGGER IF EXISTS `sluzbaIznosenjaSmeca`.`Vozac_AFTER_UPDATE` $$
USE `sluzbaIznosenjaSmeca`$$
CREATE DEFINER = CURRENT_USER TRIGGER `sluzbaIznosenjaSmeca`.`Vozac_AFTER_UPDATE` AFTER UPDATE ON `Vozac` FOR EACH ROW
BEGIN
	IF new.zauzet <> old.zauzet
    THEN
		UPDATE Kamion k
		SET k.zauzet=new.zauzet
        WHERE new.Kamion_idKamion = k.idKamion;
	END IF;
END$$


DELIMITER ;
