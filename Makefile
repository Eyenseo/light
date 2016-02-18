PREFIX=$(DESTDIR)/usr
BINDIR=$(PREFIX)/bin
MANDIR=/usr/share/man/man1

CC=gcc
CFLAGS=-std=c89 -O2 -pedantic -Wall -I"./include"
MANFLAGS=-h -h -v -V

all:
	$(CC) $(CFLAGS) -g -o light src/helpers.c src/light.c src/main.c
exp:
	$(CC) $(CFLAGS) -E  src/helpers.c src/light.c
man:
	help2man $(MANFLAGS) ./light | gzip - > light.1.gz

install: all man
	mkdir -p $(BINDIR)
	cp -f ./light $(BINDIR)/light
	chown root $(BINDIR)/light
	chmod 4755 $(BINDIR)/light
	mkdir -p $(MANDIR)
	mv light.1.gz $(MANDIR)

uninstall:
	rm $(BINDIR)/light
	rm -rf /etc/light
	rm $(MANDIR)/light.1.gz

clean:
	rm -vfr *~ light light.1.gz
	