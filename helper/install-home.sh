#!/usr/bin/sh

xmonad_mark=$HOME/.xmonad/mark
test ! -f "$xmonad_mark" && echo $HOME > $xmonad_mark

systemctl --user enable ssh-agent.service
