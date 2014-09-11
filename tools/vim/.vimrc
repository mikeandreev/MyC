" ===============================================================
" .vimrc file
" Mike Andreev
"

set nocompatible

" ===============================================================
" === === ms windows shortcuts === ===

" set the 'cpoptions' to its Vim default
"if 1	" only do this when compiled with expression evaluation
"  let s:save_cpo = &cpoptions
"endif
"set cpo&vim

if has('win32')
  " set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
  behave mswin
  
  " CTRL-Z is Undo; not in cmdline though
  noremap <C-Z> u
  inoremap <C-Z> <C-O>u

  " CTRL-Y is Redo (although not repeat); not in cmdline though
  "noremap <C-Y> <C-R>
  noremap <C-Y> <C-Y>
  "inoremap <C-Y> <C-O><C-R>
  "inoremap <C-Y> <C-O><C-Y>
endif

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X is Cut
vnoremap <C-X> "+x
" SHIFT-Del is Cut
" vnoremap <S-Del> "+x

" CTRL-C is Copy
vnoremap <C-C> "+y
" CTRL-Insert is Copy
" vnoremap <C-Insert> "+y

" CTRL-V is Paste
map <C-V>		"+gP
cmap <C-V>		<C-R>+

"SHIFT-Insert is Paste
" map <S-Insert>		"+gP
" cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
" Use CTRL-G u to have CTRL-Z only undo the paste.

exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']

" imap <S-Insert>		<C-V>
" vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif


" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" CTRL-F4 is Close window
"noremap <C-F4> <C-W>c
"inoremap <C-F4> <C-O><C-W>c
"cnoremap <C-F4> <C-C><C-W>c
"onoremap <C-F4> <C-C><C-W>c

" restore 'cpoptions'
"set cpo&
"if 1
"  let &cpoptions = s:save_cpo
"  unlet s:save_cpo
"endif

" ===============================================================
" === === My preferences === ===
set autoread
set encoding=utf-8
set number
set cursorline
"set cursorcolumn
syntax on
"set vb " turns off visual bell
set autoindent
set smartindent
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab "Current MSVC convension
"set softtabstop=4 shiftwidth=4 expandtab "Typical for Java code convension

let g:xml_syntax_folding=1
set foldmethod=syntax

"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set listchars=tab:>.,trail:~,extends:>,precedes:<
"default is not to show invisible stuff
set list !

" >>> gui 
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Courier\ New\ 11
  elseif has("gui_photon")
    set guifont=Courier\ New:s11
  elseif has("gui_kde")
    set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    "set guifont=Courier_New:h11:cRUSSIAN
    set guifont=Consolas:h10:cRUSSIAN
  endif
endif
" <<<

" >>>
" http://stackoverflow.com/questions/5375240/a-more-useful-statusline-in-vim
" http://got-ravings.blogspot.de/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
" <<<

" >>>
" http://vim.wikia.com/wiki/Easier_buffer_switching
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")
:nnoremap <F5> :buffers<CR>:buffer<Space>
" <<<

" >>> short cuts to copy file name to cliboard
" http://vim.wikia.com/wiki/Copy_filename_to_clipboard
if has('win32')
  " Convert slashes to backslashes for Windows.
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")
else
  "nmap ,cs :let @*=expand("%")
  "nmap ,cl :let @*=expand("%:p")
  nmap ,cs :let @+=expand("%")
  nmap ,cl :let @+=expand("%:p")
endif
" <<<

" >>> saving / restoring sessions
" http://stackoverflow.com/questions/5142099/auto-save-vim-session-on-quit-and-auto-reload-session-on-start
fu! SaveSess()
    execute 'call mkdir( '.expand('~\.vim').' )'
    execute 'mksession! '.expand('~\.vim\session.vim')
endfunction

fu! RestoreSess()
if filereadable(expand('~\.vim\session.vim'))
execute 'so '.expand('~\.vim\session.vim')
if bufexists(1)
    for l in range(1, bufnr('$'))
        if bufwinnr(l) == -1
            exec 'sbuffer ' . l
        endif
    endfor
endif
endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * call RestoreSess()
" <<<

