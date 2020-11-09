"=============================================================================
" FILE: highlight.vim
" AUTHOR: haya14busa
" Reference: https://github.com/t9md/vim-smalls
" License: MIT license
"=============================================================================
scriptencoding utf-8
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

function! EasyMotion#highlight#load()
   "load
endfunction

" -- Default highlighting ---------------- {{{
let g:EasyMotion_hl_group_target         = get(g:,
    \ 'EasyMotion_hl_group_target', 'EasyMotionTarget')
let g:EasyMotion_hl2_first_group_target  = get(g:,
    \ 'EasyMotion_hl2_first_group_target', 'EasyMotionTarget2First')
let g:EasyMotion_hl2_second_group_target = get(g:,
    \ 'EasyMotion_hl2_second_group_target', 'EasyMotionTarget2Second')
let g:EasyMotion_hl_group_shade          = get(g:,
    \ 'EasyMotion_hl_group_shade', 'EasyMotionShade')

let g:EasyMotion_hl_inc_search     = get(g:,
    \ 'EasyMotion_hl_inc_search', 'EasyMotionIncSearch')
let g:EasyMotion_hl_inc_cursor     = get(g:,
    \ 'EasyMotion_hl_inc_cursor', 'EasyMotionIncCursor')
let g:EasyMotion_hl_move           = get(g:,
    \ 'EasyMotion_hl_move', 'EasyMotionMoveHL')

let s:target_hl_defaults = {
    \   'gui'     : ['NONE', '#ff0000' , 'bold']
    \ , 'cterm256': ['NONE', '196'     , 'bold']
    \ , 'cterm'   : ['NONE', 'red'     , 'bold']
    \ }

let s:target_hl2_first_defaults = {
    \   'gui'     : ['NONE', '#ffb400' , 'bold']
    \ , 'cterm256': ['NONE', '11'      , 'bold']
    \ , 'cterm'   : ['NONE', 'yellow'  , 'bold']
    \ }

let s:target_hl2_second_defaults = {
    \   'gui'     : ['NONE', '#b98300' , 'bold']
    \ , 'cterm256': ['NONE', '3'       , 'bold']
    \ , 'cterm'   : ['NONE', 'yellow'  , 'bold']
    \ }

let s:shade_hl_defaults = {
    \   'gui'     : ['NONE', '#777777' , 'NONE']
    \ , 'cterm256': ['NONE', '242'     , 'NONE']
    \ , 'cterm'   : ['NONE', 'grey'    , 'NONE']
    \ }

let s:shade_hl_line_defaults = {
    \   'gui'     : ['red' , '#FFFFFF' , 'NONE']
    \ , 'cterm256': ['red' , '242'     , 'NONE']
    \ , 'cterm'   : ['red' , 'grey'    , 'NONE']
    \ }

let s:target_hl_inc = {
    \   'gui'     : ['NONE', '#7fbf00' , 'bold']
    \ , 'cterm256': ['NONE', '40'   , 'bold']
    \ , 'cterm'   : ['NONE', 'green'   , 'bold']
    \ }
let s:target_hl_inc_cursor = {
    \   'gui'     : ['#ACDBDA', '#121813' , 'bold']
    \ , 'cterm256': ['cyan'   , '232'   , 'bold']
    \ , 'cterm'   : ['cyan'   , 'black'   , 'bold']
    \ }
let s:target_hl_move = {
    \   'gui'     : ['#7fbf00', '#121813' , 'bold']
    \ , 'cterm256': ['green'  , '15'   , 'bold']
    \ , 'cterm'   : ['green'  , 'white'   , 'bold']
    \ }
" }}}
function! EasyMotion#highlight#InitHL(group, colors) " {{{
    let group_default = a:group . 'Default'

    " Prepare highlighting variables
    let guihl = printf('guibg=%s guifg=%s gui=%s', a:colors.gui[0], a:colors.gui[1], a:colors.gui[2])
    let ctermhl = &t_Co == 256
        \ ? printf('ctermbg=%s ctermfg=%s cterm=%s', a:colors.cterm256[0], a:colors.cterm256[1], a:colors.cterm256[2])
        \ : printf('ctermbg=%s ctermfg=%s cterm=%s', a:colors.cterm[0], a:colors.cterm[1], a:colors.cterm[2])

    " Create default highlighting group
    execute printf('hi default %s %s %s', group_default, guihl, ctermhl)

    " Check if the hl group exists
    if hlexists(a:group)
        redir => hlstatus | exec 'silent hi ' . a:group | redir END

        " Return if the group isn't cleared
        if hlstatus !~ 'cleared'
            return
        endif
    endif

    " No colors are defined for this group, link to defaults
    execute printf('hi default link %s %s', a:group, group_default)
endfunction " }}}
function! EasyMotion#highlight#init() "{{{
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_group_target, s:target_hl_defaults)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl2_first_group_target, s:target_hl2_first_defaults)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl2_second_group_target, s:target_hl2_second_defaults)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_group_shade,  s:shade_hl_defaults)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_inc_search, s:target_hl_inc)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_inc_cursor, s:target_hl_inc_cursor)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_move, s:target_hl_move)
endfunction "}}}

" Reset highlighting after loading a new color scheme {{{
augroup EasyMotionInitHL
    autocmd!
    autocmd ColorScheme * call EasyMotion#highlight#init()
augroup end
" }}}

call EasyMotion#highlight#init()
" Init: {{{
let s:h = {}
let s:h.ids = {}
let s:priorities = {
    \  g:EasyMotion_hl_group_target : 100,
    \  g:EasyMotion_hl2_first_group_target : 100,
    \  g:EasyMotion_hl2_second_group_target : 100,
    \  g:EasyMotion_hl_group_shade : 0,
    \  g:EasyMotion_hl_inc_search : 1,
    \  g:EasyMotion_hl_inc_cursor : 2,
    \  g:EasyMotion_hl_move : 0,
    \ }
for s:group in keys(s:priorities)
    let s:h.ids[s:group] = []
endfor
unlet s:group
"}}}

function! EasyMotion#highlight#delete_highlight(...) "{{{
    let groups = !empty(a:000) ? a:000 : keys(s:priorities)
    for group in groups
        for id in s:h.ids[group]
            silent! call matchdelete(id)
        endfor
        let s:h.ids[group] = []
    endfor
endfunction "}}}
function! EasyMotion#highlight#add_highlight(re, group) "{{{
    call add(s:h.ids[a:group], matchadd(a:group, a:re, s:priorities[a:group]))
endfunction "}}}
function! EasyMotion#highlight#add_pos_highlight(line_num, col_num, group) "{{{
    call add(s:h.ids[a:group], matchaddpos(a:group, [[a:line_num, a:col_num]], s:priorities[a:group]))
endfunction "}}}

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" __END__  {{{
" vim: expandtab softtabstop=4 shiftwidth=4
" vim: foldmethod=marker
" }}}
