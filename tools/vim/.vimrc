" ===============================================================
" .vimrc file
" Mike Andreev
"

set nocompatible
" Pathogen plugin manager
execute pathogen#infect()

let mapleader = ","
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

" 
"if exists('vsvimcaret') || has('win32')
"  set clipboard=unnamed
"else
"  set clipboard=unnamedplus
"endif
" workaround to match vsvim as win32
if has('unix')
  if has('clipboard')
    set clipboard=unnamedplus
  endif
else
  set clipboard=unnamed
endif

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
  noremap <A-Space> :simalt ~<CR>
  inoremap <A-Space> <C-O>:simalt ~<CR>
  cnoremap <A-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab and CTRL-T to switch between buffers and windows
"noremap <C-T> <C-W>w
"inoremap <C-T> <C-O><C-W>w
"cnoremap <C-T> <C-C><C-W>w
"onoremap <C-T> <C-C><C-W>w
"
"nnoremap <C-S-Tab> :tabprevious<CR>
"nnoremap <C-Tab>   :tabnext<CR>
"inoremap <C-S-Tab> <Esc>:tabprevious<CR>i
"inoremap <C-Tab>   <Esc>:tabnext<CR>i

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
" >>> locale
" http://habrahabr.ru/post/183222/
scriptencoding utf-8
" Отображение во внутренних сообщениях программы
lan mes en_GB.UTF-8
" Отображение в меню
set langmenu=en_GB.UTF-8
" spelling
"setlocal spell spelllang=ru_yo,en_us
setlocal spell spelllang=
" <<<

set number
set cursorline
"set cursorcolumn
syntax enable
set showcmd             " show command in bottom bar
set showmatch           " highlight matching [{()}]
set splitright
set splitbelow
" no visual or sound bell
set vb t_vb=
set hlsearch
"nohlsearch
set autoindent
set smartindent
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab "Current MSVC convension
autocmd FileType java setlocal softtabstop=4 shiftwidth=4 expandtab "Typical for Java code convension
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType cabal setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

autocmd FileType md setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

autocmd FileType python setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
"au FileType python setl sw=2 sts=2 et
au BufRead,BufNewFile *.ipy setfiletype python


set foldenable          " enable folding
let g:xml_syntax_folding=1
set foldmethod=syntax   " see ':help foldmethod' for more opton
set foldlevelstart=99   " open most folds by default

"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set listchars=tab:>.,trail:~,extends:>,precedes:<
"default is not to show invisible stuff
set list !

" >>> tags
" required by Taglist plugin
"filetype on
if has('win32')
  " let Tlist_Ctags_Cmd='c:\opt\ctags\ctags.exe'
  "can be checked with :echo system(Tlist_Ctags_Cmd . ' --version') 
  " tagbar
  let g:tagbar_ctags_bin='c:\opt\ctags\ctags.exe'
  "can be checked with :echo system( g:tagbar_ctags_bin . ' --version') 
endif
nmap <F8> :TagbarToggle<CR>
" <<<

" >>> CtrlP
let g:ctrlp_working_path_mode = 'cr'
" RX project
let g:ctrlp_root_markers = [ 'RMS_DBAX.vs11.sln', '.gitignore' ]
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](Debug_Win32_VS2012|Release_Win32_VS2012)$',
	\ 'file': '\v\.(exe|so|dll|jar)$',
	\ }
	" \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_max_files=0
"let g:ctrlp_max_depth=40
" <<<

" >>> gui
if has("gui_running")
  if has("gui_gtk2") " Ubuntu
    set guifont=DeJaVu\ Sans\ Mono\ 10
  elseif has("gui_photon")
    set guifont=Courier\ New:s11
  elseif has("gui_kde")
    set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else " has("win32")
    "set guifont=Courier_New:h11:cRUSSIAN
    set guifont=Consolas:h10:cRUSSIAN
  endif

  " color
  "colorscheme badwolf " https://github.com/sjl/badwolf/

  " https://github.com/altercation/Vim-colors-solarized   // http://ethanschoonover.com/solarized
  "set background=dark
  set background=light
  colorscheme solarized

  "colorscheme lucius
else " no gui_running
  "colorscheme default
  if has("win32")
    if !empty($CONEMUBUILD)
      " tested on windows with ConEmu
      "set term=xterm
      set term=pcansi
      set t_Co=256
      let &t_AB="\e[48;5;%dm"
      let &t_AF="\e[38;5;%dm"
      "set background=light
      "colorscheme solarized
      colorscheme hemisu
      set background=light
    endif
  endif

  " set background=light
  "colorscheme hemisu

  " other options:
  " ---
  "let g:lucius_style=light
  "colorscheme lucius
  " ---
  " colorscheme badwolf
  " ---
  " set background=light
  " colorscheme solarized
  " ---
  " set t_Co=256
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
:nnoremap <F6> :buffers<CR>:buffer<Space>
" <<<

" >>> short cuts to copy file name to cliboard
" http://vim.wikia.com/wiki/Copy_filename_to_clipboard
if has('win32')
  " Convert slashes to backslashes for Windows.
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
else
  "nmap ,cs :let @*=expand("%")
  "nmap ,cl :let @*=expand("%:p")
  nmap ,cs :let @+=expand("%")<CR>
  nmap ,cl :let @+=expand("%:p")<CR>
endif
" <<<

" >>> saving / restoring sessions
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
" <<<

