# load special key
source $ZDOTDIR/kbd/xterm.zsh

KEYTIMEOUT=10

function kill-whole-word () {
	zle backward-word
	zle kill-word
}
zle -N kill-whole-word

function capitalize-whole-word () {
	zle backward-word
	zle capitalize-word
}
zle -N capitalize-whole-word

function up-case-whole-word () {
	zle backward-word
	zle up-case-word
}
zle -N up-case-whole-word

function spell-whole-word () {
	zle backward-word
	zle spell-word
}
zle -N spell-whole-word

function transpose-whole-words () {
	zle vi-forward-blank-word-end
	zle transpose-words
}
zle -N transpose-whole-words


function insert-to-visual () {
	zle vi-cmd-mode
	zle visual-mode
}
zle -N insert-to-visual

function visual-to-insert () {
	zle deactivate-region
	zle vi-insert
}
zle -N visual-to-insert

bindkey -e

#bindkey '\t' expand-or-complete
bindkey '\t' expand-or-complete-prefix
bindkey "${key[Down]}" down-line-or-history
bindkey "${key[Up]}" up-line-or-history
bindkey "${key[Left]}" backward-char
bindkey "${key[Right]}" forward-char
bindkey "${key[Home]}" beginning-of-line
bindkey "${key[End]}" end-of-line
bindkey '\b' backward-delete-char
bindkey "${key[Delete]}" delete-char
bindkey "${key[Insert]}" overwrite-mode
bindkey '^[w' forward-word
bindkey '^[b' backward-word
bindkey '^[f' vi-find-next-char
bindkey '^[F' vi-find-prev-char
bindkey '^[t' vi-find-next-char-skip
bindkey '^[T' vi-find-prev-char-skip
bindkey '^[,' vi-repeat-find
bindkey '^[<' vi-rev-repeat-find
bindkey '^[/' vi-history-search-backward
bindkey '^[n' vi-repeat-search
bindkey '^[N' vi-rev-repeat-search
bindkey '^[d' kill-whole-word
bindkey '^[D' kill-whole-line
bindkey '^[C' transpose-chars
bindkey '^[c' transpose-whole-words
#bindkey '^[k' vi-swap-case
bindkey '^[`' capitalize-whole-word
bindkey '^[~' up-case-whole-word
bindkey '^[y' copy-prev-word
bindkey '^[Y' push-line
bindkey '^[p' yank
bindkey '^[P' get-line
bindkey "^['" vi-set-buffer
bindkey '^[u' undo
bindkey '^[U' redo
bindkey '^[v' insert-to-visual
bindkey '^[%' vi-match-bracket

#bindkey '^s' spell-whole-word
#visual

bindkey -M visual 'c' vi-change
bindkey -M visual 'd' vi-delete
bindkey -M visual 'y' vi-yank
# uncomment after release version5.3
#bindkey -M visual '`' vi-lowercase
#bindkey -M visual '~' vi-uppercase

bindkey -M visual '%' vi-match-bracket
bindkey -M visual "${key[Down]}" down-line
bindkey -M visual "${key[Up]}" up-line
bindkey -M visual "${key[Left]}" backward-char
bindkey -M visual "${key[Right]}" forward-char
bindkey -M visual "${key[Home]}" beginning-of-line
bindkey -M visual "${key[End]}" end-of-line

bindkey -M visual 'b' backward-word
bindkey -M visual 'w' forward-word
bindkey -M visual 'W' vi-forward-blank-word-end
bindkey -M visual 'f' vi-find-char
bindkey -M visual 'F' vi-find-prev-char
bindkey -M visual 't' vi-find-next-char-skip
bindkey -M visual 'T' vi-find-prev-char-skip
bindkey -M visual "," vi-repeat-find
bindkey -M visual '<' vi-rev-repeat-find

bindkey -M visual '\e' visual-to-insert
#
#digit-argument

#Text objects
#BUG?: no such keymap 'visual'
#bindkey -M visua1 'aw' select-a-word
#bindkey -M visua1 'iw' select-in-word
#bindkey -M visua1 'aW' select-a-blank-word
#bindkey -M visua1 'iW' select-in-blank-word
#argument
#bindkey -M visua1 'aa' select-a-shell-word
#bindkey -M visua1 'ia' select-in-shell-word
