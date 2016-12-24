#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)


if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
xsetroot -cursor_name left_ptr
amixer -c 0 set Speaker 100%
amixer set "Capture" cap
exec xmonad
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
