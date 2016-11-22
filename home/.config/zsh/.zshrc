#completion
#--------------------
autoload -Uz compinit
compinit
# only when overflow window size, ask me to see all possibilities
LISTMAX=0
# variable can complete cd ~
setopt auto_name_dirs
# don't keep slash
setopt auto_remove_slash
# show list with compact
setopt list_packed
# similar ls -F
setopt list_types
# smartcase
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# command history
#--------------------
HISTFILE=
# save history to memory
HISTSIZE=100
# save history to file
SAVEHIST=0
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
# push to directory stack with cd
setopt auto_pushd
# ls after cd
function chpwd() {
	ls -F -A
}

# ignore dupplicated direcory
setopt pushd_ignore_dups

# correct
#--------------------
# command only
setopt correct

# * expand
#--------------------
# also affect * in variable
setopt glob_subst
# add / after directory name
setopt mark_dirs
#expand to empty string if grob is null
setopt null_glob
setopt extended_glob

# etc
#--------------------
setopt no_beep
# activate comments even if not script
setopt interactive_comments
# show message when recieve mail at &mailpath
# setopt mail_warning
# setopt rc_expand_param

source $ZDOTDIR/conf.d/alias.zsh
source $ZDOTDIR/conf.d/keybind.zsh
source $ZDOTDIR/conf.d/prompt.zsh
source $ZDOTDIR/conf.d/bookmark.zsh
