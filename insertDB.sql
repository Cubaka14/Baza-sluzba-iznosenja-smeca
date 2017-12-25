use mydb;

LOAD DATA LOCAL INFILE'data/zaposleni.txt' INTO TABLE Zaposleni
  FIELDS TERMINATED BY ',';
  
LOAD DATA LOCAL INFILE'data/upravnik.txt' INTO TABLE Upravnik
  FIELDS TERMINATED BY ',';
  
LOAD DATA LOCAL INFILE'data/dispecer.txt' INTO TABLE Dispecer
  FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE'data/tipSmeca.txt' INTO TABLE TipSmeca
  FIELDS TERMINATED BY ',';  
  
LOAD DATA LOCAL INFILE'data/klijent.txt' INTO TABLE Klijent
  FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE'data/zahtevi.txt' INTO TABLE Zahtev
  FIELDS TERMINATED BY ',';  

LOAD DATA LOCAL INFILE'data/koordinator.txt' INTO TABLE Koordinator
  FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE'data/poslovi.txt' INTO TABLE Poslovi
  FIELDS TERMINATED BY ',';
  
LOAD DATA LOCAL INFILE'data/radnik.txt' INTO TABLE Radnik
  FIELDS TERMINATED BY ',';
  
LOAD DATA LOCAL INFILE'data/kamion.txt' INTO TABLE Kamion
  FIELDS TERMINATED BY ',';
  
LOAD DATA LOCAL INFILE'data/vozac.txt' INTO TABLE Vozac
  FIELDS TERMINATED BY ',';


  
