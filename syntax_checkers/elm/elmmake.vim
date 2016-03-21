"============================================================================
"File:        elmmake.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Benoît Zugmeyer <bzugmeyer at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_elm_elmmake_checker')
    finish
endif
let g:loaded_syntastic_elm_elmmake_checker = 1

if !exists('g:syntastic_elm_elmmake_sort')
    let g:syntastic_elm_elmmake_sort = 1
endif

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_elm_elmmake_GetLocList() dict
    let makeprg = self.makeprgBuild({
                \ 'args': '--warn --output="/dev/null" --yes --report=json' })

    " Standard errors and warnings
    let errorformat = '%f:%l:%c:%t: %m,'

    " Global errors without file name
    let errorformat .= '%l:%c:%t: %m'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'preprocess': 'elmmake',
        \ 'defaults': {'bufnr': bufnr('')} })

endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
            \ 'filetype': 'elm',
            \ 'name': 'elmmake',
            \ 'exec': 'elm-make' })

let &cpo = s:save_cpo
unlet s:save_cpo
