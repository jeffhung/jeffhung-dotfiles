#!/bin/sh

if [ -x $HOME/.xsession ]; then
	exec $HOME/.xsession;
else
	twm &
	xclock -geometry 50x50-1+1 &
	xterm -geometry 80x50+494+51 &
	xterm -geometry 80x20+494-0 &
	exec xterm -geometry 80x66+0+0 -name login
fi;

