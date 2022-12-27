# may be /usr/lib/systemd/system
SYSTEMDUNITDIR ?= /lib/systemd/system
BINDIR ?= /usr/bin
SBINDIR ?= /usr/sbin
AUTOSTARTDIR ?= /etc/xdg/autostart

install:
	mkdir -p $(DESTDIR)$(SYSTEMDUNITDIR)
	install -m 644 systemd/laura.path $(DESTDIR)$(SYSTEMDUNITDIR)
	install -m 644 systemd/laura.service $(DESTDIR)$(SYSTEMDUNITDIR)
	mkdir -p $(DESTDIR)$(BINDIR)
	install -m 755 bin/laura-started-de $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(SBINDIR)
	install -m 755 bin/laura-load-audit $(DESTDIR)$(SBINDIR)
	mkdir -p $(DESTDIR)$(AUTOSTARTDIR)
	install -m 644 xdg/laura.desktop $(DESTDIR)$(AUTOSTARTDIR)
