#!/bin/sh

eval `dbus-launch --sh-syntax --exit-with-session`

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

XMODIFIERS='@im=ibus'
GTK_IM_MODULE='ibus'
QT_IM_MODULE='ibus'
export XMODIFIERS GTK_IM_MODULE QT_IM_MODULE

export BROWSER='firefox'

urxvtd -q -f -o

stalonetray&

ibus-daemon -drx

exec xmonad
