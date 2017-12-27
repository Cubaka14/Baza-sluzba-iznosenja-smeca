CC  	= gcc
CCLIBS	= `mysql_config --cflags --libs`
CCFLAGS	= -Wall -g
PROGRAM	= Sluzba
OBJ 	= main.o \
		apps.o
DIR	= mysql-C
PROGS	= Sluzba

%.o: %.c
	$(CC) -c -o $@ $< $(CCFLAGS)

$(PROGRAM): $(OBJ)
	$(CC) -o $@ $^ $(CCLIBS) $(CCFLAGS)

.PHONY: all create insert beauty dist progs

progs: $(PROGRAM)

all: create insert $(PROGRAM)

create:
	mysql -u root -proot -D mysql < createDB.sql

insert:
	mysql -u root -proot -D mysql < insertDB.sql
	
beauty:
	-indent $(PROGS).c

clean:
	-rm -f *~ $(PROGS)
	
dist: beauty clean
	-tar -czv -C .. -f ../$(DIR).tar.gz $(DIR)
