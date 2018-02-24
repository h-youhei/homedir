#!/bin/sh

XMODIFIERS='@im=ibus'
GTK_IM_MODULE='ibus'
QT_IM_MODULE='ibus'
export XMODIFIERS GTK_IM_MODULE QT_IM_MODULE

ibus-daemon -drx
