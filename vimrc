syn on se title
set tabstop=4
set softtabstop=4
set shiftwidth=4

set formatoptions+=t
set expandtab!
set smarttab 
set smartindent 
let g:instant_markdown_slow = 0
filetype plugin on
filetype indent on
set t_Co=256
" colorscheme xoria256
" colorscheme gotham256
colorscheme posten
set statusline=%f\ -\ FileType:\ %y\ -\ %l\/%L
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
source ~/.vim/plugin/ScrollColor.vim
map <silent><F3> :NEXTCOLOR<cr>
map <silent><F2> :PREVCOLOR<cr>
map <C-Right> :vertical resize +10<cr>
map <C-Left> :vertical resize -10<cr>
map <C-Up> :resize -10 <cr>
map <C-Down> :resize +10<cr>
nmap <F8> :TagbarToggle<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <C-n> :NERDTreeToggle <cr>
nmap <C-b> :UndotreeToggle <cr>
nmap <F6> "+yy <cr>
nmap <F7> "+p <cr>
vmap <F6> "+yy <cr>
vmap <F7> "+p <cr>
imap <F6> "+yy <cr>
imap <F7> "+p <cr>
nmap <C-q> bvw <cr>
imap <C-q> bvw <cr>
vmap <C-q> bvw <cr>
nmap <F10> :colorscheme xoria256 <cr>
nmap <F9> :colorscheme posten <cr>
let g:jedi#popup_on_dot = 0

"Latex previewer 
let g:livepreview_previewer = 'okular'
autocmd Filetype tex setl updatetime=1

nnoremap Q gggqG
noremap <F3> :Autoformat<CR>
execute pathogen#infect()
syntax on
filetype plugin indent on
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Shortcut to rapidly toggle `set list`
 nmap <leader>l :set list!<CR>

 " Use the same symbols as TextMate for tabstops and EOLs
 set listchars=tab:▸\ ,eol:¬

" let hour = strftime("%H")
" if 6 <= hour && hour < 16
"     :colorscheme posten
"     " do daytime stuff
" else
"     :colorscheme xoria256
"     " do nighttime stuff
" endif
colorscheme xoria256
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:gitgutter_max_signs=10000
autocmd VimEnter * NERDTree 
" JSDoc configuration
let g:jsdoc_allow_input_prompt = 1
nmap <silent> <C-l> <Plug>(jsdoc)

au Filetype python setlocal tabstop=4 shiftwidth=4 expandtab!
au Filetype javascript setlocal tabstop=4 shiftwidth=4 noexpandtab autoindent

au Filetype ruby setlocal tabstop=2 shiftwidth=2 expandtab
au filetype jade setlocal tabstop=2 shiftwidth=2 expandtab tw=300
au filetype html setlocal tabstop=2 shiftwidth=2 expandtab 
au filetype js setlocal tabstop=2 shiftwidth=2 expandtab  tw=80


augroup templates
    au!
    "read in template files
    autocmd BufNewFile *.py,*.rb  execute '0r $HOME/.vim/templates/python.txt'
    autocmd BufNewFile *.js execute '0r /home/posten/.vim/templates/javascript.txt'
    autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END 

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%120v.\+/

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>
