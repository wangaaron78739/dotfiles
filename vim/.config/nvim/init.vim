"set nocompatible
set backspace=indent,eol,start 
set ruler
set showcmd
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
if has('mouse')
  set mouse=a
endif
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" Backup Directories
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

syntax on
"colorscheme molokai
"colorscheme reclipse
colorscheme gruvbox
let g:molokai_transparent = 0

set tabstop=4
set shiftwidth=4
set foldenable
set foldmethod=manual
set noerrorbells
set smartindent
set incsearch
let mapleader = " "
set expandtab

if executable('rg')
    let g:rg_derive_root='true'
endif




" vim number
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END 

set path+=**
set wildmenu

"emmet
"let g:user_emmet_install_global = 0
"autocmd FileType html,css EmmetInstall

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

	" Make sure you use single quotes

	" Multiple Plug commands can be written in a single line using

	"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	" Plug 'scrooloose/nerdtree'
	" Plug 'Xuyuanp/nerdtree-git-plugin'
	" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	" Plug 'ryanoasis/vim-devicons'
	" Plug 'christoomey/vim-tmux-navigator'
	" so ~/.vim/plug-config/nerdtree.vim

	" Plugin outside ~/.vim/plugged with post-update hook
	" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	" Plug 'junegunn/fzf.vim'
    "let $FZF_DEFAULT_COMMAND = 'rg --files'

	Plug 'lervag/vimtex'
	let g:tex_flavor='latex'
	let g:vimtex_view_method='skim'
	let g:vimtex_quickfix_mode=0
	"set conceallevel=1
	" let g:tex_conceal='agms'

	Plug 'scrooloose/nerdcommenter'
    vmap ++ <plug>NERDCommenterToggle
	nmap ++ <plug>NERDCommenterToggle

	Plug 'tpope/vim-surround' 

	Plug 'itchyny/lightline.vim'
	Plug 'airblade/vim-gitgutter'

	so ~/.vim/plug-config/coc.vim
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'sheerun/vim-polyglot'


	Plug 'justinmk/vim-sneak'
	so ~/.vim/plug-config/sneak.vim


	Plug 'unblevable/quick-scope'
	so ~/.vim/plug-config/quickscope.vim

	Plug 'SirVer/ultisnips', {'for': ['tex','cpp']}
	"let g:UltiSnipsSnippetsDir="~/.vim/snips"
    "let g:UltiSnipsSnippetDirectories=["snips","UltiSnips"]
    let g:UltiSnipsSnippetDirectories=["snips"]
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    autocmd FileType tex setlocal spell
    autocmd FileType tex set spelllang=nl,en_us
    autocmd FileType tex inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u 
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown set spelllang=nl,en_us
    autocmd FileType markdown inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u 

    Plug 'tpope/vim-fugitive'
    nmap <leader>gj :diffget //3<CR>
    nmap <leader>gf :diffget //2<CR>
    nmap <leader>gs :G<CR>

    Plug 'junegunn/goyo.vim'
    let g:goyo_linenr=1
    let g:goyo_width=100

    Plug 'ChristianChiarulli/codi.vim'
    " Change the color
    highlight CodiVirtualText guifg=cyan
    let g:codi#virtual_text_prefix = "❯ "
    let g:codi#aliases = {
                \ 'javascript.jsx': 'javascript',
                \ }

call plug#end()


"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

vnoremap <F3> :.w !pbcopy<CR><CR>
nnoremap <F3> :.w !pbcopy<CR><CR>
vnoremap <F4> :r !pbpaste<CR>
nnoremap <F4> :r !pbpaste<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++14 -DLOCAL -w % -o %:r<CR>
autocmd filetype cpp nnoremap <F10> :term ./%:r<CR> i

let g:NERDCustomDelimiters={
	\ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/* ', 'rightAlt': ' */}' },
	\}



