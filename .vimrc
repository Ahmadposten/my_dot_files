" ----- <Startify> -----
let g:startify_show_sessions = 1
let g:startify_sessions_dir = '~/.vim/sessions'
let g:startify_change_to_vcs_root = 1
let g:startify_custom_header = [
\ '    ______                  _                ',
\ '   / ____/___ _____  ____  (_)______  _______',
\ '  / / __/ __ `/ __ \/ __ \/ / ___/ / / / ___/',
\ ' / /_/ / /_/ / / / / / / / / /__/ /_/ (__  ) ',
\ ' \____/\__,_/_/ /_/_/ /_/_/\___/\__,_/____/  ',
\ '                                             ',
\ ]

" Function definitions

function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode'])
  let g:airline_section_b = airline#section#create_left(['branch', 'hunks'])
  let g:airline_section_c = airline#section#create(['%f'])
  let g:airline_section_x = airline#section#create(['filetype', ' ', '%P'])
  let g:airline_section_y = airline#section#create(['%B'])
  let g:airline_section_z = airline#section#create_right(['%l','%c'])
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
endfunction

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  setlocal linebreak
  setlocal wrap
  setlocal wrapmargin=0
  setlocal textwidth=0
  Limelight
endfunction

function! s:goyo_leave()
  setlocal nolinebreak
  setlocal nowrap
  setlocal textwidth=80
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

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

function! SetColorschemeByTOD() " Sets my colorscheme based on the time of the day
    let hour = strftime("%H")
    if 6 <= hour && hour < 16
        :colorscheme posten
    else
        :colorscheme xoria256
    endif
endfunction

" Pathogen
execute pathogen#infect()
" Plug
call plug#begin('~/.vim/plugged')
Plug 'jeetsukumaran/vim-buffergator'
Plug 'docunext/closetag.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-github-dashboard'
Plug 'mhinz/vim-startify'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'blueyed/vim-diminactive'
Plug 'easymotion/vim-easymotion'
call plug#end()

" Settings

syn on se title
set tabstop=2
set softtabstop=2
set shiftwidth=2
set formatoptions+=t
set expandtab!
set smarttab
set smartindent

" Set indentation based on filetype
au Filetype python setlocal tabstop=4 shiftwidth=4 expandtab!
au Filetype javascript setlocal tabstop=4 shiftwidth=4 noexpandtab autoindent
au Filetype ruby setlocal tabstop=2 shiftwidth=2 expandtab
au Filetype jade setlocal tabstop=2 shiftwidth=2 expandtab tw=300
au Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
au Filetype js setlocal tabstop=2 shiftwidth=2 expandtab  tw=80
set t_Co=256

" Faster Leader
set timeoutlen=100

syntax on
filetype plugin indent on

" Statusline
"set statusline=%f\ -\ FileType:\ %y\ -\ %l\/%L
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Resize of splits
map <C-Right> :vertical resize +10<cr>
map <C-Left> :vertical resize -10<cr>
map <C-Up> :resize -10 <cr>
map <C-Down> :resize +10<cr>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Beautify json
nmap <Leader>j :%!python -m json.tool<cr>

" Move between splits using alt
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Nerdtree
" autocmd VimEnter * NERDTree " Start nerdtree on startup
nmap <C-x> :NERDTreeToggle <cr>

" Undo tree
nmap <C-b> :UndotreeToggle <cr>

" Copy and paste from/to clipboard using F6, F7
nmap <F6> "+yy <cr>
vmap <F6> "+yy <cr>
nmap <F7> "+p <cr>
vmap <F7> "+p <cr>

" Easily use favorite colorschemes
nmap <F10> :colorscheme xoria256 <cr>
nmap <F9> :colorscheme posten <cr>

" Jedi python autocompletion
let g:jedi#popup_on_dot = 0

" Latex previewer
let g:livepreview_previewer = 'okular'
autocmd Filetype tex setl updatetime=1

" Remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" Indentation and formatting
nnoremap Q gggqG
noremap <F3> :Autoformat<CR>

" Setlist shortcut`
nmap <leader>l :set list!<CR>

" symbols
set listchars=tab:\|\ ,eol:¬,space:.

" Before 4 PM i need a white screen, I need a black after that
call SetColorschemeByTOD()
" JSDoc configuration
let g:jsdoc_allow_input_prompt = 1
nmap <silent> <C-l> <Plug>(jsdoc)

" When I start working on a new file, add a template with my name, email and
" metadata descriping file and time
augroup templates
    au!
    "read in template files
    autocmd BufNewFile *.py,*.rb  execute '0r $HOME/.vim/templates/python.txt'
    autocmd BufNewFile *.js execute '0r $HOME/.vim/templates/javascript.txt'
    autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

" When I exceed 120 characters per line give me a red highlight warning
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%120v.\+/

" ----- <Ability to swap splits using leader mw, leader pw> -----
nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" ----- <Vim github dashboard> -----
let g:github_dashboard = { 'username': 'Ahmadposten', 'password': $GITHUB_PASSWORD }

" ----- <Vim-go> -----
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)

" ----- <python syntax> -----
let python_highlight_all = 1

" ----- <Typos> -----
command WQ wq
command Wq wq
command W w
command Q q

" ----- <vim indentation> -----
let g:indentLine_enabled = 0
nmap <leader>ig :IndentLinesToggle<CR>

" ----- <Gitgutter> -----
let g:gitgutter_max_signs=10000
set updatetime=250
nnoremap <Leader><Right> :GitGutterPreviewHunk<CR>
nnoremap <c-j> :GitGutterNextHunk<CR>
nnoremap <c-k> :GitGutterPrevHunk<CR>
nnoremap <Leader><Leader><Left> :GitGutterRevertHunk<CR>

" ----- <Ag> -----
" & would search for a function with a name of curr word, ^ would scan
" all files
nmap  <silent> & :Ag! "def <cword>" <CR>
nmap <silent> ^ :Ag! <cword> <CR>

" ----- <ctrlp> -----
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    let g:ctrlp_use_caching = 0
endif

" ----- <Highlighting> -----
:noremap <F4> :set hlsearch! hlsearch?<CR>
:nnoremap <CR> :nohlsearch<CR><CR>

" ----- <Vim markdown> -----
let g:instant_markdown_slow = 0

" ----- <Switching colorschemes> -----
source ~/.vim/plugin/ScrollColor.vim
map <silent><F12> :NEXTCOLOR<cr>
map <silent><F2> :PREVCOLOR<cr>

" ----- <Limelight> -----
nmap <C-a> :Limelight!! <CR>

" ----- <Goyo> -----
nmap <Leader>g :Goyo
let g:goyo_width = 80
let g:goyo_height = '85%'
let g:goyo_linenr = 1
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" ----- <Vim-diminactive> -----
:hi ColorColumn ctermbg=145
let g:diminactive_use_colorcolumn = 1
let g:diminactive_enable_focus = 1
let opt_DimInactiveWin=145
autocmd VimEnter * DimInactiveOff
nmap <Leader>h :DimInactiveToggle <CR>

" ----- <Zoom> -----
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-w> :ZoomToggle<CR>

" ----- <Multiple cursors> -----
let  g:multi_cursor_use_default_mapping=0
let  g:multi_cursor_next_key='<C-i>'
let  g:multi_cursor_prev_key='<C-u>'
let  g:multi_cursor_skip_key='<C-o>'
let  g:multi_cursor_quit_key='<Esc>'
let  g:multi_cursor_start_key='<F5>'

" ----- <Easymotion> -----
" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" ----- <Airline> -----
autocmd VimEnter * call AirlineInit()


" ----- <Buffers> -----
nmap <leader>T :enew<CR>
nmap <leader>w :bnext<CR>
nmap <leader>q :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

" ----- <Buggergator> -----
nmap <leader>b :BuffergatorToggle<CR>
