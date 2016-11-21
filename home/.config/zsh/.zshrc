# Created by newuser for 5.0.7

autoload -Uz compinit; compinit

#source $ZDOTDIR/conf.d/

# keybind
#--------------------
# control io (stop<C-s> restart<C-q>)
unsetopt flow_control
# deactivate push <C-d> to end zsh
setopt ignore_eof

# completion
#--------------------
# variable can complete cd ~
setopt auto_name_dirs
# don't keep slash
setopt auto_remove_slash
# smartcase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# show list with compact
setopt list_packed


# command history
#--------------------
HISTFILE=
# save history to memory
HISTSIZE=100
# save history to file
SAVEHIST=0
# share around zsh
#setopt share_history
# ignore dupplicated command
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
# save timestamp
setopt extended_history
# edit history before do command
setopt hist_verify
# remove extra blanks
setopt hist_reduce_blanks
#setopt hist_subst_pattern

# directory
#--------------------
# auto push to directory stack
setopt auto_pushd
# ls when cd
function chpwd() {
	ls -F -A
}

# ignore dupplicated direcory
setopt pushd_ignore_dups

# correct
#--------------------
# command
setopt correct

# glob
#--------------------
# can use variable
setopt glob_subst
# show dir/ when show directory
setopt mark_dirs
#setopt csh_null_glob
#setopt null_glob
setopt extended_glob

# etc
#--------------------
setopt no_beep
# activate comments even if not script
setopt interactive_comments
# show message when recieve mail at &mailpath
# setopt mail_warning
# push '' to send '
# setopt rc_quotes
# setopt rc_expand_param

source $ZDOTDIR/conf.d/alias.zsh
source $ZDOTDIR/conf.d/keybind.zsh
source $ZDOTDIR/conf.d/prompt.zsh
source $ZDOTDIR/conf.d/bookmark.zsh
