if has('__COMMENDED_OUT__')
" http://stackoverflow.com/questions/5142099/auto-save-vim-session-on-quit-and-auto-reload-session-on-start
if has('win32')
    let g:save_session_path=expand('~\.vim\session.vim')
else
    let g:save_session_path=expand('~/.vim/session.vim')
endif

fu! SaveSess()
    execute 'mksession! '.g:save_session_path
endfunction

fu! RestoreSess()
if !filereadable(g:save_session_path)
 return
endif
execute 'so '.g:save_session_path
if bufexists(1)
    for l in range(1, bufnr('$'))
        if bufwinnr(l) == -1
            exec 'sbuffer ' . l
        endif
    endfor
endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * call RestoreSess()
endif

