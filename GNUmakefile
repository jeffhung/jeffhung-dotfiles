UENV_DOT_FILES =# list of ~/.* files to install
UENV_DOT_FILES += $(HOME)/.bashrc
UENV_DOT_FILES += $(HOME)/.ctags
UENV_DOT_FILES += $(HOME)/.gitignore
UENV_DOT_FILES += $(HOME)/.indent.pro
UENV_DOT_FILES += $(HOME)/.logmonrc
UENV_DOT_FILES += $(HOME)/.nexrc
UENV_DOT_FILES += $(HOME)/.uncrustify.cfg
UENV_DOT_FILES += $(HOME)/.screenrc

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

ifeq ($(UENV_OS_FAMILY),Darwin)
FORCE_LINK = ln -sfFh
else
FORCE_LINK = echo FORCE_LINK
endif

.PHONY: all
all: help

.PHONY: debug
debug:
	@echo "UENV_OS_FAMILY=$(UENV_OS_FAMILY)"

.PHONY: help
help:
	@echo "Usage: make help              # show this help message";
	@echo "       make dotfiles-install  # install dot files";
	@echo "       make perlbrew-install  # install PerlBrew";

# ----------------------------------------------------------------------------
# Dot files in HOME (~/.*)
# ----------------------------------------------------------------------------

.PHONY: dotfiles-install
dotfiles-install: $(UENV_DOT_FILES)

define UENV_DOT_FILE_RULES
$(1):
	@echo "[UENV] Install $(notdir $(1))";
	@( \
	cd $(dir $(1)); \
	$(FORCE_LINK) $(abspath home/dot$(notdir $(1))) $(notdir $(1)); \
	);
endef
$(foreach f,$(UENV_DOT_FILES),$(eval $(call UENV_DOT_FILE_RULES,$(f))))

# ----------------------------------------------------------------------------
# Perlbrew
# ----------------------------------------------------------------------------

.PHONY: perlbrew-install
perlbrew-install: ~/perl5/perlbrew

.PHONY: perlbrew-uninstall
perlbrew-uninstall:
	rm -rf ~/perl5/perlbrew;
	rm -rf ~/.perlbrew;

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


