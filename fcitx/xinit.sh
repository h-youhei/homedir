#!/bin/sh

XMODIFIERS='@im=fcitx'
GTK_IM_MODULE='fcitx'
QT_IM_MODULE='fcitx'
export XMODIFIERS GTK_IM_MODULE QT_IM_MODULE

fcitx -r
