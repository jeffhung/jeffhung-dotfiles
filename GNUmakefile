UENV_ENABLE_PERLBREW = yes

# Determine OS family. We aim to support these: Debian, RHEL, Darwin, FreeBSD
# See: http://www.novell.com/coolsolutions/feature/11251.html
UENV_OS_FAMILY = $(shell uname)
ifeq ($(UENV_OS_FAMILY),Linux)
ifneq ($(shell ls /etc/debian_version),)
UENV_OS_FAMILY = Debian
endif
ifneq ($(shell ls /etc/redhat-release /etc/fedora-release),)
UENV_OS_FAMILY = RHEL
endif
endif

.PHONY: all
all: help

.PHONY: debug
debug:
	@echo "UENV_OS_FAMILY=$(UENV_OS_FAMILY)"

.PHONY: help
help:
	@echo "Usage: make help              # show this help message";
	@echo "       make perlbrew-install  # install PerlBrew";

.PHONY: perlbrew-install
perlbrew-install: ~/perl5/perlbrew

~/perl5/perlbrew:
	@echo "[UENV] Installing 'perlbrew'...";
ifeq ($(UENV_OS_FAMILY),Darwin)
	# XXX: Homebrew does not support perlbrew yet. This line is here to
	#      demonstrate $(UENV_OS_FAMILY).
	brew install perlbrew;
else
	curl -L http://xrl.us/perlbrewinstall | bash;
endif
	@echo "[UENV] There is no need to append 'source ~/perl5/perlbrew/etc/bashrc' to your ~/.bashrc.";

.PHONY: perlbrew-uninstall
perlbrew-uninstall:
	rm -rf ~/perl5/perlbrew;
	rm -rf ~/.perlbrew;


