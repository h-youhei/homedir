if exists('b:did_indent')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists('b:undo_indent')
    let b:undo_indent = ''
else
    let b:undo_indent .= '|'
endif

let b:undo_indent .= 'setlocal
    \ indentexpr<
    \ autoindent<
    \ indentkeys<
    \'

setlocal indentexpr=SnippetsIndent()
setlocal autoindent
setlocal indentkeys=o,O,=snippet\ ,=include\ ,=delete\ ,=abbr\ ,=prev_word\ ,=alias\ ,=options\ ,=regexp\ ,!^F

function! SnippetsIndent() abort
    let line = getline('.')
    let prev_line = (line('.') == 1)? '' : getline(line('.')-1)

    "for indentkeys o,O
    if s:is_empty(line)
        if prev_line =~ '^\s*\%(include\|delete\)\s'
            return 0
        elseif s:is_define(prev_line)
            return shiftwidth()
        else
            return -1
        endif
    "for indentkeys =words
    else
        if s:is_syntax(line) && (s:is_define(prev_line) || s:is_empty(prev_line))
            return 0
        else
            return -1
        endif
    endif
endfunction

function! s:is_empty(line)
    return a:line =~ '^\s*$'
endfunction

function! s:is_define(line)
    return a:line =~ '^\s*\%(snippet\|abbr\|prev_word\|alias\|options\|regexp\)\s'
endfunction

function! s:is_syntax(line)
    return a:line =~ '^\s*\%(snippet\|include\|delete\|abbr\|prev_word\|alias\|options\|regexp\)\s'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

let b:did_indent = 1
