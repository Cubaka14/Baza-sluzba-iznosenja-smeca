#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include <stdarg.h>
#include <errno.h>
#include "apps.h"


/* Funkcija error_fatal() ispisuje poruku o gresci i potom prekida program. */
static void error_fatal (char *format, ...);

int main (int argc, char **argv)
{

    MYSQL *konekcija;	/* Promenljiva za konekciju. */
    MYSQL_RES *rezultat;	/* Promenljiva za rezultat. */
    MYSQL_ROW red;	/* Promenljiva za jedan red rezultata. */
    MYSQL_FIELD *polje;	/* Promenljiva za nazive kolona. */
    int i;		/* Brojac u petljama. */
    int broj;		/* Pomocna promenljiva za broj kolona. */	

    char query[QUERY_SIZE];	/* Promenljiva za formuaciju upita. */
    char buffer[BUFFER_SIZE];	/* Velicina poruke koja se ucitava sa ulaza. */

    /* Incijalizuje se promenljiva koja ce predstavljati konekciju. */
    konekcija = mysql_init (NULL);
    
    /* Pokusava se sa konektovanjem na bazu. */
    if (mysql_real_connect
        (konekcija, "localhost", "root", "root", "mydb", 0, NULL,
        0) == NULL)
        error_fatal ("Greska u konekciji. %s\n", mysql_error (konekcija));

    while(1){
        printf("\n--------------------\nUnesite svoju sifru:");
        if(scanf("%s", buffer) == EOF){
            if(ferror(stdin))
                error_fatal("Greska u funkciji scanf(): %s\n", strerror(errno));
            else
                exit(EXIT_SUCCESS);
        }
        
        /* Izdvajaju se sifre i nazivi predmeta na tom profilu. */
        sprintf (query, "select * from Zaposleni where sifra = \"%s\"", buffer);

        /* Pokusava se sa izvrsavanjem upita. */
        if (mysql_query (konekcija, query) != 0)
            error_fatal ("Greska u upitu %s\n", mysql_error (konekcija));
        /* Preuzima se rezultat. */
        rezultat = mysql_use_result (konekcija);

        if(rezultat == NULL)
            error_fatal ("Pogresna sifra: %s\n", buffer);
        
        if((red = mysql_fetch_row (rezultat)) == 0)
            error_fatal ("Pogresna sifra: %s\n", buffer);

        printf("Dobro dosli %s %s . Ulogovani ste kao %s\n",red[1],red[2],red[8]);
        if(!strcmp(red[8],"upravnik"))
        {
            app_upravnik(konekcija,red[0]);
        }
        else if(!strcmp(red[8],"dispecer"))
        {
            app_dispecer(konekcija,red[0]);
        }
        else if(!strcmp(red[8],"koordinator"))
        {
            app_koordinator(konekcija);
        }
        else if(!strcmp(red[8],"klijent"))
        {
            app_klijent(konekcija);
        }
        else if(!strcmp(red[8],"radnik"))
        {
            app_radnik(konekcija);
        }
        else if(!strcmp(red[8],"vozac"))
        {
            app_vozac(konekcija);
        }
        /* Oslobadja se trenutni rezultat, posto nam vise ne treba. */
        mysql_free_result (rezultat);
    }

    /* Zatvara se konekcija. */
    mysql_close (konekcija);

    /* Zavrsava se program */
    exit(EXIT_SUCCESS);
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
