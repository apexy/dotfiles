" Leader
let mapleader = " "

set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line

set undodir=~/.vim/tmp/undo//     " undo files
set undofile
set undolevels=1000         "maximum number of changes that can be undone
set undoreload=10000        "maximum number lines to save for undo on a buffer reload

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Encoding
set enc=utf-8
set fenc=utf-8 " default fileencoding
set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936,big5,euc-jp,euc-kr,latin1

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Set PHP, HTML file tabs
  autocmd FileType php set ai tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufReadPost *.html setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Color scheme
colorscheme hybrid
set guifont=Menlo\ Regular:h13
"highlight NonText guibg=#060606
"highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

set dictionary-=~/.vim/dict/funclist.txt dictionary+=~/.vim/dict/funclist.txt

" Remove trailing whitespaces when saving
" Wanna know more? http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

" Snippets are activated by Shift+Tab
" let g:snippetsEmu_key = "<S-Tab>"

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction
" inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Mappings {{{

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

" Easy buffer navigation
nnoremap <Up> <ESC>:bN<CR>
nnoremap <Down> <ESC>:bn<CR>
nnoremap <Left> <<
nnoremap <Right> >>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Begining & End of line in Normal mode
noremap H ^
noremap L g_

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :

" better ESC
inoremap jj <Esc>
inoremap uu _

"make the tab key match bracket pairs
nmap <tab> %
vmap <s-tab> %

" Insert New Line without going into insert mode
map <Enter> o<ESC>

" Yank content in OS's clipboard. `o` stands for OS's Clipoard.
vnoremap <leader>yo "*y
" Paste content from OS's clipboard
nnoremap <leader>po "*p

"add a '====' line above current line
nmap <leader>1 yyPVr=
"add a '----' line above current line
nmap <leader>2 yyPVr-
"add a '####' line above current line
nmap <leader>3 yyPVr#

"}}}

" Plugin {{{

nmap <C-u> :NERDTreeToggle<CR>
nmap <leader>y :YRShow<cr>
nmap <leader>bb :CtrlPBuffer<CR>
nmap <leader>rr :CtrlPMRU<CR>
let g:sparkupExecuteMapping='<c-b>'
" let g:UltiSnipsExpandTrigger="<s-tab>"
let g:rspec_command = "!bundle exec rspec {spec}"


" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=1
let g:syntastic_enable_highlighting = 0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
"let g:syntastic_phpcs_conf = "--tab-width=4 --standard=CodeIgniter"
nmap E :Errors<cr>


nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

"}}}

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
