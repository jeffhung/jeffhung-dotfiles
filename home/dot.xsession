#!/bin/tcsh -x
# no -f in the previous line so .cshrc gets run to set $PATH

setenv	XRESOURCES_USER	"$HOME/.Xresources"
setenv	XRESOURCES_SYS	"/usr/local/lib/X11/xinit/.Xresources"
setenv	XMODMAP_USER	"$HOME/.Xmodmap"
setenv	XMODMAP_SYS		"/usr/local/lib/X11/xinit/.Xmodmap"

set vmware_toolbox_cmd = `whereis -bq vmware-toolbox`;
if ( $%vmware_toolbox_cmd > 0 ) then
	"$vmware_toolbox_cmd" &
endif

set xmodmap_cmd = `whereis -bq xmodmap`;
if ( $%xmodmap_cmd > 0 ) then
	if ( `hostname` == 'dev.jeffhung.net' ) then
		# For fixing up strange keycode for NumLock on IBM SpaceSaver II keyboard
		#
		# <quote from="http://www.webservertalk.com/message2042369.html">
		# Fire up xev and take a look at the keycodes reported when you push
		# {various modifiers}+BkSpace.  IBM Thinkpads use a strange keycode for
		# NumLock; Shift+ScrollLock produces keycode 77, which you have to xmodmap
		# to NumLock.
		#
		# If something (shift or alt) together with backspace produces a keycode
		# different from the normal backspace keycode, all you should have to do
		# is find that keycode and do "xmodmap -e 'keycode NN = Num_Lock' ".  Once
		# you've figured that out, have something that runs at your WM/DE startup
		# execute that xmodmap command.
		#
		# This should happen automagically if the keyboard's behaving properly.
		# At least it did on all the Thinkpads with NumLock that I've had.
		# </quote>
		"$xmodmap_cmd" -e 'keycode 77 = Num_Lock';
	endif
endif

set xrdb_cmd = `whereis -bq xrdb`;
if ( ($%xrdb_cmd > 0 ) && ( -r "$XRESOURCES_USER" ) ) then
	"$xrdb_cmd" "$XRESOURCES_USER";
endif

#set xset_cmd = `whereis -bq xset`;
## ============================================================
## American Math Society Postscript fonts have been installed!
## ============================================================
## Please add      /usr/local/share/fonts/amspsfont/type1
## to your X11 fonts path by either:
## 
## $ xset fp+  /usr/local/share/fonts/amspsfont/type1
## $ xset fp rehash
## 
## or by adding it to your X-server configuration file.
## Other utilities, like ghostscript, may also need
## additional configuration.
## ============================================================
#if ( ( $%xset_cmd > 0 ) && ( -d /usr/local/share/fonts/amspsfont/type1 ) ) then
#	"$xset_cmd" fp+ /usr/local/share/fonts/amspsfont/type1
#	"$xset_cmd" fp  rehash
#endif
## ============================================================
## Computer Modern Postscript fonts have been installed!
## ============================================================
## Please add      /usr/local/share/fonts/cmpsfont/type1
## to your X11 fonts path by either:
## 
## $ xset fp+  /usr/local/share/fonts/cmpsfont/type1
## $ xset fp rehash
## 
## or by adding it to your X-server configuration file.
## Other utilities, like ghostscript, will probably also need
## configuration.
## ============================================================
#if ( ( $%xset_cmd > 0 ) && ( -d /usr/local/share/fonts/cmspsfont/type1 ) ) then
#	"$xset_cmd" fp+ /usr/local/share/fonts/cmspsfont/type1
#	"$xset_cmd" fp  rehash
#endif

set gcin_cmd = `whereis -bq gcin`;
if ( $%gcin_cmd > 0 ) then
	"$gcin_cmd" &
endif

set gnome_settings_daemon_cmd = `whereis -bq gnome-settings-daemon`;
if ( $%gnome_settings_daemon_cmd == 0 ) then
	if ( -x /usr/local/libexec/gnome-settings-daemon ) then
		set gnome_settings_daemon_cmd = '/usr/local/libexec/gnome-settings-daemon';
	endif
endif
# We won't start gnome-settings-daemon here, since gnome-session will start
# one.  So, we will only manually start gnome-settings-daemon if we're running
# window manager other than gnome.

# Force to use gnome for better looking openoffice.org.
# OOO_FORCE_DESKTOP could be kde, gnome, or none.
set openoffice_2_2_0_cmd = `whereis -bq openoffice.org-2.2.0`;
if ( ( $%openoffice_2_2_0_cmd > 0 ) && ( $%gnome_settings_daemon_cmd > 0) ) then
	setenv OOO_FORCE_DESKTOP gnome
endif

#set nautilus_cmd = `whereis -bq nautilus`;
#if ($%nautilus_cmd > 0 ) then
#	"$nautilus_cmd" --no-default-window &
#0endif

set selectwm_cmd = `whereis -bq selectwm`;
if ( $%selectwm_cmd > 0 ) then
	exec "$selectwm_cmd";
else
	foreach window_manager (gnome icewm compiz xfce4 fluxbox twm)
		echo "Trying $window_manager...";
		set window_manager_launched='no';
		switch ($window_manager)
		case compiz:
			set compiz_cmd=`whereis -bq compiz`;
			if ( $%compiz_cmd > 0 ) then
				if ( $%gnome_settings_daemon_cmd > 0 ) then
					"$gnome_settings_daemon_cmd" &
				endif
				exec "$compiz_cmd";
				window_manager_launched='yes';
			endif
			breaksw
		case twm:
			set twm_cmd=`whereis -bq twm`;
			if ( $%twm_cmd > 0 ) then
				"$twm_cmd" &
				if ( $%gnome_settings_daemon_cmd > 0 ) then
					"$gnome_settings_daemon_cmd" &
				endif
				xclock -geometry 50x50-1+1 &
				xterm -geometry 80x50+494+51 &
				xterm -geometry 80x20+494-0 &
				exec xterm -geometry 80x66+0+0 -name login;
				window_manager_launched='yes';
			endif
			breaksw
		case gnome:
			set gnome_session_cmd=`whereis -bq gnome-session`;
			if ( $%gnome_session_cmd > 0 ) then
				exec "$gnome_session_cmd";
				window_manager_launched='yes';
			endif
			breaksw
		case icewm:
			set icewm_session_cmd=`whereis -bq icewm-session`;
			if ( $%icewm_session_cmd > 0 ) then
				if ( $%gnome_settings_daemon_cmd > 0 ) then
					"$gnome_settings_daemon_cmd" &
				endif
				exec "$icewm_session_cmd";
				window_manager_launched='yes';
			endif
			breaksw
		case xfce4:
			set xfce4_session_cmd=`whereis -bq xfce4-session`;
			if ( $%xfce4_session_cmd > 0 ) then
				if ( $%gnome_settings_daemon_cmd > 0 ) then
					"$gnome_settings_daemon_cmd" &
				endif
				exec "$xfce4_session_cmd";
				window_manager_launched='yes';
			endif
			breaksw
		case fluxbox:
			set startfluxbox_cmd=`whereis -bq startfluxbox`;
			if ( $%startfluxbox_cmd > 0 ) then
				if ( $%gnome_settings_daemon_cmd > 0 ) then
					"$gnome_settings_daemon_cmd" &
				endif
				exec "$startfluxbox_cmd";
				window_manager_launched='yes';
			endif
			breaksw
		default:
			window_manager_launched='unknown-wm-error';
			breaksw
		endsw
	
		if ( $window_manager_launched == 'yes' ) then
			break; # foreach
		else if ( $window_manager_launched == 'unknown-wm-error' ) then
			echo "ERROR: Unknown window manager.";
			break; # foreach
		endif
	end # foreach ($window_manager)
endif # if ( $%selectwm_cmd > 0 )

