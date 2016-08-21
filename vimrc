set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'nanotech/jellybeans.vim'

Plugin 'tpope/vim-surround'

Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'

Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'ConradIrwin/vim-bracketed-paste'

Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'
Plugin 'adoy/vim-php-refactoring-toolbox'

Plugin 'mhinz/vim-startify'

Plugin 'scrooloose/syntastic' " pear install PHP_CodeSniffer + phpmd

Plugin 'tpope/vim-fugitive' " sudo apt-get install git
Plugin 'airblade/vim-gitgutter'

Plugin 'szw/vim-tags' " apt-get install exuberant-ctags
Plugin 'majutsushi/tagbar'

Plugin 'rking/ag.vim' " apt-get install silversearcher-ag

Plugin 'joonty/vdebug' " sudo pecl install xdebug
Plugin 'Shougo/vimproc' " vim +VimProcInstall +qall
Plugin 'Shougo/vimshell.vim'

Plugin 'SirVer/ultisnips' " vim 7.4+
Plugin 'honza/vim-snippets'
Plugin 'sniphpets/sniphpets'

Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'Valloric/YouCompleteMe' " https://github.com/Valloric/YouCompleteMe#full-installation-guide

Plugin 'evidens/vim-twig'

Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on

let mapleader = "\<Space>"

" enable the mouse
if has("mouse")
   set mouse=a
endif

" theme
set t_Co=256
try
    colorscheme jellybeans
catch
endtry

" PDV
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" табуляция
set tabstop=4
set shiftwidth=4
set smarttab
set et " Converting tabs to spaces
set ai " автоотступы для новых строк
set cin " отступы в стиле Си

" airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''

autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

" vim-tags
let g:vim_tags_project_tags_command = "{CTAGS} -R {OPTIONS} {DIRECTORY} 2>/dev/null"

" gitgutter
set updatetime=950
let g:gitgutter_sign_column_always = 1
let g:gitgutter_map_keys = 0

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Startify
" let g:startify_custom_header = map(split(system(''), '\n'), '"   ". v:val')
let g:startify_change_to_vcs_root = 1
let g:startify_session_persistence = 1
let g:startify_bookmarks = ['~/.vim/vimrc','~/.zshrc','~/.oh-my-zsh/custom/themes/my-theme.zsh-theme',]

" NERDTree
nmap <Leader>n :NERDTree<CR>

" VimShell
let g:vimshell_split_command = 'vsplit'

" Xdebug
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9001

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:ctrlp_reuse_window = 'startify'

let g:ctrlp_funky_multi_buffers = 1
let g:ctrlp_funky_php_requires = 1
let g:ctrlp_funky_php_include = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

" fugitive
nmap gs :Gstatus<CR>
nmap gb :Gblame<CR>
nmap gl :Glog<CR>
nmap gc :Gcommit<CR>
nmap hs :GitGutterStageHunk<CR>
nmap hr :GitGutterRevertHunk<CR>
nmap hp :GitGutterPreviewHunk<CR>
nmap hj :GitGutterNextHunk<CR>
nmap hk :GitGutterPrevHunk<CR>

" tabs
:set tabpagemax=10
nnoremap th :tabfirst<CR>
nnoremap tj :tabprev<CR>
nnoremap tk :tabnext<CR>
nnoremap tl :tablast<CR>
nnoremap tn :tabnew<CR>
nnoremap tt :tabnew<CR>:Startify<CR>
nnoremap td :tabclose<CR>

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    return s
endfunction

function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return bufname(buflist[winnr - 1])
endfunction
:set tabline=%!MyTabLine()

" ретаб + удаление trailing spaces
" nmap <Leader>t :%retab<CR>:%s/\s\+$<CR>:noh<CR>
" function! Trim() call Preserve('%s/\s\+$//e') endfunction

" NERDTree
nmap <Leader>n :NERDTree<CR>

" copy
nmap <Leader>y "+Y
vmap <Leader>y "+y
nmap <C-C> "+Y
vmap <C-C> "+y

" paste
nmap <Leader>p "+p

" buffers
nmap <Leader>b :ls<CR>:e

" search
set showmatch
set hlsearch
set incsearch
set ignorecase
nmap <Leader>/ :noh<CR>

set wildmenu " better command-line completion
set showcmd " показывать комманды внизу экрана

set viminfo='20,\"90,h,%    " read/write a .viminfo file
set history=500

set laststatus=2 " всегда показывать статусную строку

set confirm " confirmation instead of error on exit w/o saving

set novisualbell
set vb t_vb=

" бекапы
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

set cursorline

syntax on

set number
set relativenumber

set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
:set list

set splitbelow
set splitright

set matchpairs+=<:>

" This will allow Vim to use your custom .vimrc in the current working directory.
" set exrc
" set secure
