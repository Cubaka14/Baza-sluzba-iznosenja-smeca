#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include <stdarg.h>
#include <errno.h>


#define QUERY_SIZE 256

#define BUFFER_SIZE 80

void app_upravnik(MYSQL *konekcija,char * idUpravnika);
void app_koordinator(MYSQL *konekcija);
void app_klijent(MYSQL *konekcija);
void app_dispecer(MYSQL *konekcija,char* idDispecera);
void app_radnik(MYSQL *konekcija);
void app_vozac(MYSQL *konekcija);
