if ( $?DISPLAY  ) then
	xapp.sh --register "$DISPLAY";
	setenv DISPLAY_ORI	"$DISPLAY"
	unsetenv DISPLAY;
endif

# Automatically go into screen when login.
if ( ( ! $?WINDOW ) && ( `echo $tty | sed 's/.$//'` == 'ttyp' )) then
	if ( ( -x /usr/local/bin/screen ) || ( -x /usr/bin/screen ) ) then
		screen;
	endif
endif

