#!/bin/sh

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

XMODIFIERS='@im=fcitx'
GTK_IM_MODULE='fcitx'
QT_IM_MODULE='fcitx'
export XMODIFIERS GTK_IM_MODULE QT_IM_MODULE
type fcitx && fcitx


export BROWSER='firefox'


LANG='ja_JP.UTF-8'
LC_MESSAGES='en_US.UTF-8'
export LANG LC_MESSAGES

type xmonad && exec xmonad
