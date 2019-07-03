#man zshzle
##/STANDARD WIDGETS

# disable control io (stop<C-s> restart<C-q>)
unsetopt flow_control
# disable <C-d> (exit zsh)
setopt ignore_eof

# load special key
for f in  $ZDOTDIR/terminal/?*.zsh ; do
	source $f
done
unset f

KEYTIMEOUT=10

function kill-whole-word () {
	zle backward-word
	zle kill-word
}
zle -N kill-whole-word

function insert-to-visual () {
	zle vi-cmd-mode
	zle visual-mode
}
zle -N insert-to-visual

function insert-to-visual-line () {
	zle vi-cmd-mode
	zle visual-line-mode
}
zle -N insert-to-visual-line

function visual-to-insert () {
	zle deactivate-region
	zle vi-insert
}
zle -N visual-to-insert

function cd-parent () {
	builtin echo
	builtin cd ..
	zle send-break
	zle push-line
}
zle -N cd-parent

bindkey -e

bindkey '^u' cd-parent

[ -z "$key[BackTab]" ] || bindkey "${key[BackTab]}" reverse-menu-complete
bindkey "${key[Down]}" history-beginning-search-forward
bindkey "${key[Up]}" history-beginning-search-backward
bindkey "${key[Left]}" backward-char
bindkey "${key[Right]}" forward-char
bindkey "${key[Home]}" beginning-of-line
bindkey "${key[End]}" end-of-line
bindkey '\b' backward-delete-char
bindkey "${key[Delete]}" delete-char
bindkey "${key[Insert]}" overwrite-mode
bindkey '\eb' backward-word
bindkey '\eB' vi-backward-blank-word
bindkey '\ed' kill-whole-word
bindkey '\eD' kill-whole-line
bindkey '\ee' vi-forward-word-end
bindkey '\eE' vi-forward-blank-word-end
bindkey '\ef' vi-find-next-char
bindkey '\eF' vi-find-prev-char
bindkey '\ei' insert-last-word
bindkey '\eL' kill-line
bindkey '\el' backward-kill-line
bindkey '\ep' yank
bindkey '\eP' get-line
bindkey '\er' transpose-words
bindkey '\et' vi-find-next-char-skip
bindkey '\eT' vi-find-prev-char-skip
bindkey '\eu' undo
bindkey '\eU' redo
bindkey '\ev' insert-to-visual
bindkey '\eV' insert-to-visual-line
bindkey '\ew' forward-word
bindkey '\ey' copy-prev-word
bindkey '\eY' push-line
bindkey '\e~' vi-swap-case
bindkey '\e,' vi-repeat-find
bindkey '\e<' vi-rev-repeat-find
bindkey "\e'" vi-set-buffer
bindkey '\em' vi-match-bracket
bindkey '\e:' execute-named-cmd
bindkey '\e' send-break

#visual
bindkey -M visual "${key[Down]}" down-line
bindkey -M visual "${key[Up]}" up-line
bindkey -M visual "${key[Left]}" backward-char
bindkey -M visual "${key[Right]}" forward-char
bindkey -M visual "${key[Home]}" beginning-of-line
bindkey -M visual "${key[End]}" end-of-line
bindkey -M visual '\b' vi-delete
bindkey -M visual "${key[Delete]}" vi-delete

bindkey -M visual 'b' backward-word
bindkey -M visual 'w' forward-word
bindkey -M visual '`' vi-uppercase
bindkey -M visual '~' vi-lowercase
bindkey -M visual 'm' vi-match-bracket
bindkey -M visual ',' vi-repeat-find
bindkey -M visual '<' vi-rev-repeat-find

bindkey -M visual '\e' visual-to-insert
