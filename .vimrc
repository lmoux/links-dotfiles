set bomb
set paste
set autoindent
set cindent
set smartindent
set sw=2
set nocompatible
filetype plugin on
set ofu=syntaxcomplete#Complete
execute pathogen#infect()

map <f10> :e ++enc=utf-16le<CR>

map <Leader>e :e <C-R>=expand('%:p:h') . '/'

function! GotoDefinition()
"   echo("\<".expand("<cword>")."\\>[^(]*([^)]*)\\s*\\n*\\s*{")
  let n = search("\\<".expand("<cword>")."\\>[^(]*([^)]*)\\s*\\n*\\s*{")
endfunction
map <F4> :call GotoDefinition()<CR>
imap <F4> <c-o>:call GotoDefinition()<CR>

set laststatus=2
set backspace=2
set nobackup
set nowritebackup
set title
set viminfo='1000,n~/.vim/_viminfo'

map <F5> :e<CR>
map <F2> :NERDTreeToggle<CR>
map <C-f2> :source ~/.vimrc<CR>

set nobackup
syntax enable           " enable syntax processing
set tabstop=4       " number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set number
set showcmd
set cursorline
filetype indent on      " load filetype-specific indent files

set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.

set showmatch           " highlight matching [{()}]
" With showmatch, when your cursor moves over a parenthesis-like character, the matching one will be highlighted as well.

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR> 
" Doug > Vim will keep highlighted matches from searches until you either run a new one or manually stop highlighting the old search with :nohlsearch. I find myself running this all the time so I've mapped it to ,<space>.

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

" space open/closes folds
nnoremap <space> za
set foldmethod=marker " fold based on indent level

set backspace=2

"set background=light
colorscheme koehler

execute pathogen#infect()

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    "autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java
    "                        \:call <SID>StripTrailingWhitespaces() <CR>
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd FileType *.js setlocal shiftwidth=2
augroup END
" Much from http://dougblack.io/words/a-good-vimrc.html

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction 
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
au FileType javascript call JavaScriptFold()
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" Make vim watch for new .vimrc changes
" http://stackoverflow.com/questions/2400264/is-it-possible-to-apply-vim-configurations-without-restarting/2403926#2403926
"augroup myvimrc
"    au!
"    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
"augroup END

