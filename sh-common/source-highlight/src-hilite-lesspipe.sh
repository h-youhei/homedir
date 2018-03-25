#! /bin/sh

style=$HOME/.source-highlight/esc.style

for source in "$@"; do
	case $source in
		*ChangeLog|*changelog) 
			source-highlight --failsafe -f esc --lang-def=changelog.lang --style-file=$style -i "$source" ;;
		*Makefile|*makefile) 
			source-highlight --failsafe -f esc --lang-def=makefile.lang --style-file=$style -i "$source" ;;
		#*.tar|*.tgz|*.gz|*.bz2|*.xz)
	 	#	lesspipe "$source" ;;
	 	#lang-def=zsh.lang is broken
	 	*.zsh)
			source-highlight --failsafe --lang-def=sh.lang -f esc --style-file=$style -i "$source" ;;
		*)
			source-highlight --failsafe --infer-lang -f esc --style-file=$style -i "$source" ;;
    esac
done
