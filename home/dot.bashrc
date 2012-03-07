umask 022

append_path () {
	input="$1"
	value="$2"
	if ! echo $input | egrep -q "(^|:)$value($|:)" ; then
		if [ "$3" = "after" ] ; then
			echo $input:$value
		else
			echo $value:$input
		fi
	else
		echo $input
	fi
}

UNAME=`uname`;
if [ "$UNAME" = "Darwin" ]; then
	export OS_DARWIN=1;
fi;

# Setup EDITOR vairable.
if [ "$UNAME" = "Darwin" ]; then
	export EDITOR="/usr/bin/vim";
	alias view="$EDITOR -R";
elif [ "$UNAME" = "FreeBSD" ]; then
	if [ -x "/usr/local/bin/vim" ]; then
		export EDITOR="/usr/local/bin/vim";
	elif [ -x "/usr/local/bin/nvi" ]; then
		export EDITOR="/usr/local/bin/nvi";
	else
		export EDITOR="/usr/bin/vi";
	fi;
	alias view="$EDITOR -R";
elif [ "$UNAME" = "Linux" ]; then
	export EDITOR="vim";
	alias view="$EDITOR -R";
fi;

# Setup JAVA_HOME vairable.
if [ "$UNAME" = "Darwin" ]; then
	export JAVA_HOME=`/usr/libexec/java_home`;
elif [ "$UNAME" = "FreeBSD" ]; then
	export JAVA_HOME="/usr/local";
elif [ "$UNAME" = "Linux" ]; then
	export JAVA_HOME="/usr/lib/jvm/java-6-sun";
fi;

# Setup PERL5LIB variable
if [ "$UNAME" = "Darwin" ]; then
	export PERL5LIB="`append_path "$PERL5LIB" "$HOME/perl5/lib/perl5" "after"`";
	export PERL5LIB="`append_path "$PERL5LIB" "/opt/zookeeper/lib/perl5/site_perl/5.10.0/darwin-thread-multi-2level/auto" "after"`";
	export PERL5LIB="`append_path "$PERL5LIB" "/opt/zookeeper/lib/perl5/site_perl/5.10.0/darwin-thread-multi-2level" "after"`";

	export PERL5OPT="$PERL5OPT -I$HOME/perl5/lib/perl5"
	export PERL5OPT="$PERL5OPT -I/opt/zookeeper/lib/perl5/site_perl/5.10.0/darwin-thread-multi-2level/auto"
	export PERL5OPT="$PERL5OPT -I/opt/zookeeper/lib/perl5/site_perl/5.10.0/darwin-thread-multi-2level"

	# Make cpanm install to local.
	export PERL_CPANM_OPT="--local-lib=$HOME/perl5"
fi;

export LC_ALL=en_US.UTF-8

# Brew: Add the following lines to your ~/.bash_profile file:
which brew > /dev/null 2>&1;
if [ "$?" = '0' ]; then
	if [ -f `brew --prefix`/etc/bash_completion ]; then
		. `brew --prefix`/etc/bash_completion
	fi
fi;
#if [ -f /opt/local/etc/bash_completion ]; then
#	. /opt/local/etc/bash_completion
#fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt=yes;;
xterm-256color) color_prompt=yes;;
screen)  color_prompt=yes;;
screen-bce)  color_prompt=yes;;
esac
case "$COLORTERM" in
gnome-terminal) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such a
		# case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

git_prompt_info()
{
	# branch name
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	branch="${ref#refs/heads/}";
	# since last commit (https://gist.github.com/897951)
	last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
	now=`date +%s`;
	seconds=$((now-last_commit));
	minutes=$((seconds/60));
	hours=$((minutes/60));
	minutes=$((minutes%60));
	days=$((hours/24));
	hours=$((hours%24));
	since_last_commit="${days}d${hours}h${minutes}m";
	# combine the above
	echo ":${branch}:${since_last_commit}";
}

ps1_euser=`whoami`; # effective user name
if [ "$color_prompt" = yes ]; then
	ps1_standout='\[\e[7m\]'
	ps1_bold='\[\e[1m\]'
	ps1_reset='\[\e[0m\]'
fi;
if [ -z "$WINDOW" ]; then
	if [ "$USER" == "$ps1_euser" ]; then
		export PS1="\n$ps1_standout\h$ps1_reset:[$ps1_bold$USER$ps1_reset][\t][\w\$(git_prompt_info)]\n[\!]${debian_chroot:+($debian_chroot)}\$ "
	else
		export PS1="\n$ps1_standout\h$ps1_reset:[$ps1_bold$USER$ps1_reset]($ps1_euser)][\t][\w\$(git_prompt_info)]\n[\!]${debian_chroot:+($debian_chroot)}\$ "
	fi;
else
	if [ "$USER" == "$ps1_euser" ]; then
		export PS1="\n$ps1_standout\h$ps1_reset:[$ps1_bold$USER$ps1_reset:$ps1_bold$WINDOW$ps1_reset][\t][\w\$(git_prompt_info)]\n[\!]${debian_chroot:+($debian_chroot)}\$ "
	else
		export PS1="\n$ps1_standout\h$ps1_reset:[$ps1_bold$USER$ps1_reset($ps1_euser):$ps1_bold$WINDOW$ps1_reset][\t][\w\$(git_prompt_info)]\n[\!]${debian_chroot:+($debian_chroot)}\$ "
	fi;
fi
unset color_prompt force_color_prompt ps1_euser ps1_standout ps1_bold ps1_reset

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	eval "`dircolors -b`"
	alias ls='ls --classify --color=auto'
#	alias dir='dir --color=auto'
#	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
elif [ `uname` = 'Darwin' ]; then
	alias ls='ls -GF';
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Alias definitions
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them before directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases;
fi;

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

alias irssi='env LC_ALL=zh_TW.UTF-8 irssi'

[ -z "$MANPATH" ] && export MANPATH="/usr/share/man:/usr/local/man";

if [ -d /Developer/usr/bin ]; then
	export PATH="`append_path "$PATH" "/Developer/usr/bin" "after"`";
fi;

if [ -d $HOME/perl5/bin ]; then
	export PATH="`append_path "$PATH" "$HOME/perl5/bin" "before"`";
#	if [ -z '`echo $PATH | grep -o '$HOME/bin'`' ]; then
#		export PATH="$HOME/bin:$PATH";
#	fi;
fi

if [ -d $HOME/bin ]; then
	export PATH="`append_path "$PATH" "$HOME/bin" "before"`";
#	if [ -z '`echo $PATH | grep -o '$HOME/bin'`' ]; then
#		export PATH="$HOME/bin:$PATH";
#	fi;
fi

if [ -d $HOME/local/bin ]; then
	export PATH="`append_path "$PATH" "$HOME/local/bin" "before"`";
#	if [ -z "`echo $PATH | grep -o '$HOME/local/bin'`" ]; then
#		export PATH="$HOME/local/bin:$PATH";
#	fi;
fi;

#if [ -d /opt/jdk/bin ]; then
#	if [ -z `echo $PATH | grep -o ':/opt/jdk/bin'` ]; then
#		export PATH="$PATH:/opt/jdk/bin";
#	fi;
#	if [ -z `echo $MANPATH | grep -o ':/opt/jdk/man'` ]; then
#		export MANPATH="$MANPATH:/opt/jdk/man";
#	fi;
#fi

# Setup Perforce environment
export P4CONFIG='.p4config'
export P4PORT='TW-P4Proxy:1667'
export P4USER='jeff_hung'

export SVNBASE='http://tw-jeffhung.client.tw.trendnet.org/svn'

if [ -x /usr/bin/colormake ]; then
	alias gmake='colormake -j8'
else
	alias gmake='make -j8'
fi;

#if [ -x "$HOME/tmp/LogMon-0.4.4/bin/logmon" ]; then
#	logmon_cmd="$HOME/tmp/LogMon-0.4.4/bin/logmon";
#	if [ -r "$HOME/tmp/LogMon-0.4.4/etc/logmon.conf" ]; then
#		logmon_cmd="$logmon_cmd -f $HOME/tmp/LogMon-0.4.4/etc/logmon.conf";
#	fi;
#	alias logmon="$logmon_cmd";
#	unset logmon_cmd;
#fi;

export SVN_SSH="ssh -i ${HOME}/.ssh/id_rsa-passphraseless"
export RSYNC_RSH="ssh -i ${HOME}/.ssh/id_rsa-passphraseless"

# The time(1) command in Debian GNU/Linux accept a superset of resource
# specifiers that recognized by the tcsh(1) builtin ‘time’ command. So we can
# use the following format string in both tcsh(1) and Debian GNU/Linux
# environment.
# jeffhung.20090811:
# - Unlike tcsh(1), bash(1) do not need anti-slash at end-of-line as a line
#   continuation.
export TIME='
| Time | %Es (user: %Us, kernel: %Ss, CPU utilisation: %P)
| Mem  | average: %X+%D=%K KB (max: %Mk)
| I/O  | input operations: %I, output operations: %O
| IPC  | socket in: %r, socket out: %s, signals: %s
| Swap | %W swaps (major page faults: %F, minor page faults: %R)
| Wait | %w waits (involuntary context switches: %c)'


export ANT_HOME="/usr/share/ant";
export ANT_OPTS="-Dhttp.proxyHost=proxy.trend.com.tw -Dhttp.proxyPort=8080"

if [ -x "$HOME/bin/wcgrep.sh" ]; then
	alias wcgrep="$HOME/bin/wcgrep.sh";
else
	alias wcgrep='grep';
fi;

export PAGER="`which less` --search-skip-screen --quit-if-one-screen --hilite-search --LONG-PROMPT";
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\E[38;5;167m'
export LESS_TERMCAP_md=$'\E[38;5;39m'
export LESS_TERMCAP_me=$'\E[38;5;231m'
export LESS_TERMCAP_se=$'\E[38;5;231m'
export LESS_TERMCAP_so=$'\E[38;5;167m'
export LESS_TERMCAP_ue=$'\E[38;5;231m'
export LESS_TERMCAP_us=$'\E[38;5;167m'
alias more="$PAGER";

export LSCOLORS="exfxcxdxbxegedabagacad"
# dark background
export LSCOLORS="`echo $LSCOLORS | tr a-g A-G`"

export UMLET_HOME="$HOME/opt/umlet";

alias csshX="env VERSIONER_PERL_PREFER_32_BIT=yes csshX"

#export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:"


#if [ -d /usr/local/git ]; then
#	if [ -d /usr/local/git/bin ]; then
#		export PATH="`append_path "$PATH" "/usr/local/git/bin" "after"`";
#		export MANPATH="`append_path "$MANPATH" "/usr/local/git/share/man" "after"`";
#	fi;
#fi;

export PATH="`append_path "$PATH" "$HOME/wc/ADE/ADE/bin" "after"`";

if [ -d "$HOME/local/lib/python2.6" ]; then
	export PYTHONPATH="$HOME/local/lib/python2.6:$HOME/local/lib/python2.6/site-packages";
fi;

if [ -d "$HOME/wc/tcloud-issues" ]; then
	export DITRACK_ROOT="$HOME/wc/tcloud-issues";
fi;

if [ -d ~/perl5/perlbrew ]; then
	source ~/perl5/perlbrew/etc/bashrc
fi;

