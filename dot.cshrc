if ( ! $?WINDOW ) then
#	alias	screen	'env LC_CTYPE=en_US.ISO8859-1 /usr/local/bin/screen -x -RR'
	if ( $USER == `whoami` ) then
		alias	screen	'screen -x -RR'
	else
		alias	screen	"screen -x -RR -c ${HOME}/.screenrc-${USER}"
	endif
#else
#	alias	screen	'env LC_CTYPE=en_US.ISO8859-1 /usr/local/bin/screen'
endif

setenv SVN_SSH   "ssh -l jeffhung -i ${HOME}/.ssh/id_rsa-svn"
setenv RSYNC_RSH "ssh -l jeffhung -i ${HOME}/.ssh/id_rsa-svn"

# The time(1) command in Debian GNU/Linux accept a superset of resource
# specifiers that recognized by the tcsh(1) builtin ‘time’ command. So we can
# use the following format string in both tcsh(1) and Debian GNU/Linux
# environment.
# jeffhung.20090813: I have to duplicate this setting.
setenv TIME '\
| Time | %Es (user: %Us, kernel: %Ss, CPU utilisation: %P)\
| Mem  | average: %X+%D=%K KB (max: %Mk)\
| I/O  | input operations: %I, output operations: %O\
| IPC  | socket in: %r, socket out: %s, signals: %s\
| Swap | %W swaps (major page faults: %F, minor page faults: %R)\
| Wait | %w waits (involuntary context switches: %c)'

# Various statistics.
# You can unset it or set it (it is set a bit later).
# Do "man tcsh" to find about more data that can be shown
# with this command. I have used only those that are available
# on a Linux box without kernel debugging enabled.
# That is, a stock kernel from a distribution.
#unset time
#set time="%Uu %Ss %E %P %X+%Dk %I+%Oio %Fpf+%Ww"
if ( $?WINDOW ) then
	# 8 means the time builtin (q.v.) executes automatically after each command
	# which takes more than that many CPU seconds.
	set time=(8 "\
| Time | %Es (user: %Us, kernel: %Ss, CPU utilisation: %P)\
| Mem  | average: %X+%D=%K KB (max: %Mk)\
| I/O  | input operations: %I, output operations: %O\
| IPC  | socket in: %r, socket out: %s, signals: %s\
| Swap | %W swaps (major page faults: %F, minor page faults: %R)\
| Wait | %w waits (involuntary context switches: %c)")
	# jeffhung.20060329: old time setting:
	#	set time=(8 "\
	#Time spent in user mode   (CPU seconds) : %Us\
	#Time spent in kernel mode (CPU seconds) : %Ss\
	#Total time                              : %Es\
	#CPU utilisation (percentage)            : %P\
	#Times the process was swapped           : %W\
	#Times of major page faults              : %F\
	#Times of minor page faults              : %R")
endif

# Watch any(1) other users every 0 seconds from any(2) console,
# when logging in/out.(I like this one!)
# It gives something like "root has logged on tty1 from local."
# You may find it annoying on busy systems (like shell1.sourceforge.net)
set watch=(0 any any)

# Format of output string when someone logins or logouts.(Look above)
# Hmm, can't be internationalised easily.
set who="%n has %a %l from %M."

# Set to 'insert' mode. Possible values 'insert' or 'overwrite'.
# By default, we are in "insert" mode.
set inputmode=insert

# Don't want to be autologed out.
# You can set it to autologout you after x minutes of idle time.
# You would do: set autologout=3  for 3 minutes of inactivity.
unset autologout

# Symbolic links are expanded to their true values : chase
# (possible values 'chase' 'ignore' 'expand')
# When traversing directories with symlinks, this substitures them
# with the real value. You will like it.
#set symlinks=chase

# If the exit value is non-zero, print it.
# Very handy when you do scripting.
set printexitvalue

# Ask for confirmation when 'rm *'.
set rmstar

alias	see           'more -x4'
alias	bbs           'bbsclient.sh'

#alias	svn           'env LC_MESSAGES=C svn'
#alias	svnadmin      'env LC_MESSAGES=C svnadmin'
#alias	svndumpfilter 'env LC_MESSAGES=C svndumpfilter'
#alias	svnlook       'env LC_MESSAGES=C svnlook'
#alias	svnsync       'env LC_MESSAGES=C svnsync'
#alias	svk           'env LC_MESSAGES=C svk'

# Set default amplitude to 0.6 (decrease).
alias	play        'play --volume=0.6'

# Set if we're using screen(1)'s shell title feature.
setenv	HAVE_SCREEN_SHELLTITLE	'YES'

#if ( -x $HOME/vim7/bin/vim7 ) then
#	alias	vi	"$HOME/vim7/bin/vim7 -p"
#endif
#if ( -x $HOME/vim7/bin/view7 ) then
#	alias	view	"$HOME/vim7/bin/view7"
#endif

setenv	SUDO_PROMPT	"Enter password for '%u' to sudo to '%U': "

setenv	ADE_HOME	"$HOME/wc/ADE/ADE"
setenv	PERL5LIB	"$ADE_HOME/lib/p5:$HOME/wc/ADE/adk-perl"

alias	portupgrade	'portupgrade --verbose --interactive --recursive --upward-recursive'

# Completion for ports.pl
set ports_pl_cmds=( install upgrade deinstall search options );
complete ports.pl p/1/\$ports_pl_cmds/;
alias	porter ports.pl
complete porter p/1/\$ports_pl_cmds/;

# @see http://svn.haxx.se/users/archive-2004-07/1452.shtml
if ( -x /usr/local/bin/svn ) then
	set svn_cmds=( \
		add annotate blame cat changelist checkout cleanup commit copy delete \
		diff export help import info list lock log merge mergeinfo mkdir move \
		pdel pedit pget plist praise propdel propedit propget proplist \
		propset pset remove rename resolved revert status stat switch unlock \
		update \
	);
	complete svn p/1/\$svn_cmds/;
endif
if ( -x /usr/local/bin/svnadmin ) then
	set svnadmin_cmds=(\
		crashtest create deltify dump help hotcopy list-dblogs \
		list-unused-dblogs load lslocks lstxns pack recover rmlocks rmtxns \
		setlog setrevprop setuuid upgrade verify \
	);
	complete svnadmin p/1/\$svnadmin_cmds/;
endif
if ( -x /usr/local/bin/svnlook ) then
	set svnlook_cmds=(\
		author cat changed date diff dirs-changed help history info lock log \
		propget pget proplist plist tree uuid youngest \
	);
	complete svnlook p/1/\$svnlook_cmds/;
endif
if ( -x /usr/local/bin/svndumpfilter ) then
	set svndumpfilter_cmds=(exclude include help);
	complete svnlook p/1/\$svndumpfilter_cmds/;
endif
if ( -x /usr/local/bin/svnsync ) then
	set svnsync_cmds=(initialize synchronize copy-revporps info help);
	complete svnsync p/1/\$svnsync_cmds/;
endif

if ( -r /usr/local/share/mercurial/contrib/tcsh_completion ) then
	source /usr/local/share/mercurial/contrib/tcsh_completion;
endif

##
## !!EXPERIMENTAL!!
##
## Use alias to taste the feel of using scm-tool commands
##
## 1. Sub command cannot easily been aliased with extra options.  For example,
##    This works: `alias scm-log 'scm-log --stop-on-copy'', but this does not
##    work: `alias svn --stop-on-copy' when using subcommand other than log.
## 2. Wrap to make different SCM interface symmetric.  For example, map
##    `scm-info' to `cvs status' when within CVS working copy.
##
set scm_cmds=(                \
	add                       \
	blame praise annotate ann \
	cat                       \
	changelist cl             \
	checkout co               \
	cleanup                   \
	commit ci                 \
	copy cp                   \
    delete del remove rm      \
	diff di                   \
	export                    \
	help h                    \
	import                    \
	info                      \
	list ls                   \
	lock                      \
	log                       \
	login                     \
	logout                    \
	merge                     \
	mergeinfo                 \
    mkdir                     \
	move mv rename ren        \
	propdel pdel pd           \
	propedit pedit pe         \
	proplist plist pl         \
    propset pset ps           \
	resolve                   \
	resolved                  \
	revert                    \
	status stat st            \
	switch sw                 \
	unlock                    \
	update up                 \
);
complete scm p/1/\$scm_cmds/;

if ( -x /usr/local/bin/cdargs ) then
	alias cv 'cdargs \!* && cd `cat $HOME/.cdargsresult`'
endif


