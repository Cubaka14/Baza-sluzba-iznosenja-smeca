#include"apps.h"
/* Funkcija error_fatal() ispisuje poruku o gresci i potom prekida program. */
static void error_fatal (char *format, ...);

void app_upravnik(MYSQL *konekcija,char* idUpravnika){
    MYSQL_RES *rezultat;	/* Promenljiva za rezultat. */
    MYSQL_ROW red;	        /* Promenljiva za jedan red rezultata. */
    MYSQL_FIELD *polje;	        /* Promenljiva za nazive kolona. */
    int i;		        /* Brojac u petljama. */
    int broj;		        /* Pomocna promenljiva za broj kolona. */	
    char query[QUERY_SIZE];	/* Promenljiva za formuaciju upita. */
    char buffer[BUFFER_SIZE];	/* Velicina poruke koja se ucitava sa ulaza. */

    /* Incijalizuje se promenljiva koja ce predstavljati konekciju. */
    konekcija = mysql_init (NULL);
    /* Pokusava se sa konektovanjem na bazu. */
    if (mysql_real_connect
                (konekcija, "localhost", "root", "root", "mydb", 0, NULL,
                0) == NULL)
        error_fatal ("Greska u konekciji. %s\n", mysql_error (konekcija));
    
    int izlaz=0;
    while(!izlaz){
        printf("--------------------------------------\n");
        printf("Izaberite neku od funkcionalnosti:\n");
        printf("vidi sve radnike (KEY:1)\n");
        printf("suspendovanje radnika (KEY:2)\n");
        printf("zaposljavanje radnika (KEY:3)\n");
        printf("otpustanje radnika (KEY:4)\n");
        printf("log out (KEY:5)\n");
        printf("--------------------------------------\n");
    
        int komanda;
        scanf("%d",&komanda);
        switch(komanda){
            case 1:{
                sprintf(query,"select * from Zaposleni");
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));

                /* Preuzima se rezultat. */
                rezultat = mysql_use_result (konekcija);

                /* Ispisuje se zaglavlje kolone. */
                polje = mysql_fetch_field (rezultat);
                
                /* Racuna se broj kolona. */
                broj = mysql_num_fields (rezultat);

                for (i = 0; i < broj; i++)
                    printf ("%s\t", polje[i].name);
                printf ("\n");
                
                /* Ispisuju se vrednosti. */
                while ((red = mysql_fetch_row (rezultat)) != 0){
                    for (i = 0; i < broj; i++)
                        printf ("%s\t", red[i]);
                    printf ("\n");
                }
                
                
                /* Oslobadja se trenutni rezultat, posto nam vise ne treba. */
                mysql_free_result (rezultat);
                
            }
                break;
            case 2:{
                int id;
                char razlog[256];
                char datum[11];
                printf("Unesite id radnika:");
                scanf("%d", &id);
                printf("Unesite razlog(opciono):");
                scanf("%s", razlog);
                printf("Unesite vreme do kada je suspendovan:");
                scanf("%s", datum);
                sprintf(query,"insert into Suspendovani values('%d','%s','%s',CURDATE(),'%s')",id,idUpravnika,razlog,datum);
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
                printf("Uspesno ste suspendovali radnika id:%d\n\n",id);
            }
                break;
            case 3:{
                int id;
                char ime[20];
                char prezime[20];
                float plata;
                int brojRadnihDana;
                int brojSlobodnihDana;
                char sifra[20];
                char pozicija[20];
                
                printf("Id:");
                scanf("%d",&id);
                printf("Ime:");
                scanf("%s",ime);
                printf("Prezime:");
                scanf("%s",prezime);
                printf("Plata:");
                scanf("%f",&plata);
                printf("Broj radnih dana:");
                scanf("%d",&brojRadnihDana);
                printf("Broj slobodnih dana:");
                scanf("%d",&brojSlobodnihDana);
                printf("Sifra:");
                scanf("%s",sifra);
                printf("Pozicija:");
                scanf("%s",pozicija);
                sprintf(query,"insert into Zaposleni values('%d','%s','%s','%f','%d','%d',CURDATE(),'%s','%s')",id,ime,prezime,plata,brojRadnihDana,brojSlobodnihDana,sifra,pozicija);
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
                printf("Uspesno ste zaposlili radnika id:%d\n\n",id);
                
            }
                break;
            case 4:{
                int id;
                printf("Unesite id radnika:");
                scanf("%d",&id);
                sprintf(query,"delete from Zaposleni where idZaposleni='%d'",id);
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
                printf("Uspesno ste otpustili radnika id:%d\n\n",id);
            }
                break;
            case 5:{
                printf("Izlogovani ste!");
                izlaz=1;
            }
                break;
        }
    }
}
void app_koordinator(MYSQL *konekcija){
    printf("app_koordinator\n");
    
}
void app_klijent(MYSQL *konekcija){
    printf("app_klijent\n");
    
}
void app_dispecer(MYSQL *konekcija,char* idDispecera){
    MYSQL_RES *rezultat;	/* Promenljiva za rezultat. */
    MYSQL_ROW red;	        /* Promenljiva za jedan red rezultata. */
    MYSQL_FIELD *polje;	        /* Promenljiva za nazive kolona. */
    int i;		        /* Brojac u petljama. */
    int broj;		        /* Pomocna promenljiva za broj kolona. */	
    char query[QUERY_SIZE];	/* Promenljiva za formuaciju upita. */
    char buffer[BUFFER_SIZE];	/* Velicina poruke koja se ucitava sa ulaza. */

    /* Incijalizuje se promenljiva koja ce predstavljati konekciju. */
    konekcija = mysql_init (NULL);
    /* Pokusava se sa konektovanjem na bazu. */
    if (mysql_real_connect
                (konekcija, "localhost", "root", "root", "mydb", 0, NULL,
                0) == NULL)
        error_fatal ("Greska u konekciji. %s\n", mysql_error (konekcija));
    
    int izlaz=0;
    while(!izlaz){
        printf("--------------------------------------\n");
        printf("Izaberite neku od funkcionalnosti:\n");
        printf("Vidi sve zahteve (KEY:1)\n");
        printf("Vidi stanje poslova (KEY:2)\n");
        printf("Obradi zahtev (KEY:3)\n");
        printf("Vidi sve koordinatore (KEY:4)\n");
        printf("Odgovori na zahtev (KEY:5)\n");
        printf("log out (KEY:6)\n");
        printf("--------------------------------------\n");
    
        int komanda;
        scanf("%d",&komanda);
        switch(komanda){
            case 1:{
                sprintf(query,"select * from Zahtev");
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));

                /* Preuzima se rezultat. */
                rezultat = mysql_use_result (konekcija);

                /* Ispisuje se zaglavlje kolone. */
                polje = mysql_fetch_field (rezultat);
                
                /* Racuna se broj kolona. */
                broj = mysql_num_fields (rezultat);

                for (i = 0; i < broj; i++)
                    printf ("%s\t", polje[i].name);
                printf ("\n");
                
                /* Ispisuju se vrednosti. */
                while ((red = mysql_fetch_row (rezultat)) != 0){
                    for (i = 0; i < broj; i++)
                        printf ("%s\t", red[i]);
                    printf ("\n");
                }
                
                /* Oslobadja se trenutni rezultat, posto nam vise ne treba. */
                mysql_free_result (rezultat);
                
            }
                break;
            case 2:{
                sprintf(query,"select * from Poslovi");
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));

                /* Preuzima se rezultat. */
                rezultat = mysql_use_result (konekcija);

                /* Ispisuje se zaglavlje kolone. */
                polje = mysql_fetch_field (rezultat);
                
                /* Racuna se broj kolona. */
                broj = mysql_num_fields (rezultat);

                for (i = 0; i < broj; i++)
                    printf ("%s\t", polje[i].name);
                printf ("\n");
                
                /* Ispisuju se vrednosti. */
                while ((red = mysql_fetch_row (rezultat)) != 0){
                    for (i = 0; i < broj; i++)
                        printf ("%s\t", red[i]);
                    printf ("\n");
                }
                
                /* Oslobadja se trenutni rezultat, posto nam vise ne treba. */
                mysql_free_result (rezultat);
            }
                break;
            case 3:{
                int id;
                int  idKoord;
                char datumZav[11];
                printf("IdZahteva:");
                scanf("%d",&id);
                printf("Id koordinatora:");
                scanf("%d",&idKoord);
                printf("Datum planiranog zavrsetka:");
                scanf("%s",datumZav);
                sprintf(query,"insert into Poslovi values('%s','%d','%d','','0','%s')",idDispecera,idKoord,id,datumZav);
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
                printf("Uspesno ste prosledili posao id:%d\n\n",id);
                
            }
                break;
            case 4:{
                
                sprintf(query,"select k.Zaposleni_idZaposleni,z.ime,z.prezime,s.naziv from Koordinator k join Zaposleni z on z.idZaposleni=k.Zaposleni_idZaposleni join TipSmeca s on s.idTipSmeca=k.TipSmeca_idTipSmeca");
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));

                /* Preuzima se rezultat. */
                rezultat = mysql_use_result (konekcija);

                /* Ispisuje se zaglavlje kolone. */
                polje = mysql_fetch_field (rezultat);
                
                /* Racuna se broj kolona. */
                broj = mysql_num_fields (rezultat);

                for (i = 0; i < broj; i++)
                    printf ("%s\t", polje[i].name);
                printf ("\n");
                
                /* Ispisuju se vrednosti. */
                while ((red = mysql_fetch_row (rezultat)) != 0){
                    for (i = 0; i < broj; i++)
                        printf ("%s\t", red[i]);
                    printf ("\n");
                }
                
                /* Oslobadja se trenutni rezultat, posto nam vise ne treba. */
                mysql_free_result (rezultat);
            }
                break;
            case 5:{
                int id;
                char odgovor[200];
                printf("Unesite id Zahteva:");
                scanf("%d",&id);
                printf("Unesite odgovor na zahtev:");
                scanf("%s",odgovor);
                
                sprintf(query,"update Zahtev set odgovorDispecera='%s' where idZahtev='%d'",odgovor,id);
                
                /* Pokusava se sa izvrsavanjem upita. */
                if (mysql_query (konekcija, query) != 0)
                    error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
                printf("Uspesno ste odgovorili na zahtev id:%d\n\n",id);
            }
                break;
            case 6:{
                printf("Izlogovani ste!");
                izlaz=1;
            }
                break;
        }
    }
    
}
void app_radnik(MYSQL *konekcija){
    printf("app_radnik\n");
    
}
void app_vozac(MYSQL *konekcija){
    printf("app_vozac\n");
    
}


static void error_fatal (char *format, ...)
{
  va_list arguments;		/* Lista argumenata funkcije. */

  /* Stampa se string predstavljen argumentima funkcije. */
  va_start (arguments, format);
  vfprintf (stderr, format, arguments);
  va_end (arguments);

  /* Prekida se program. */
  exit (EXIT_FAILURE);
}
