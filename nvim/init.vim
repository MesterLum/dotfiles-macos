set encoding=utf-8
set number relativenumber
syntax enable
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
set cmdheight=1

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set fileformat=unix

call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/Zenburn'
Plug 'chriskempson/base16-vim'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'navarasu/onedark.nvim'

Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'mxw/vim-jsx'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'norcalli/nvim-colorizer.lua'

"Dart/Flutter
Plug 'dart-lang/dart-vim-plugin'
"Plug 'thosakwe/vim-flutter'
"Plug 'natebosch/vim-lsc'
"Plug 'natebosch/vim-lsc-dart'

" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'natebosch/dartlang-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'Neevash/awesome-flutter-snippets'


" Tailwind

" Git integration
"
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Svelte
Plug 'leafOfTree/vim-svelte-plugin'

call plug#end()

" Enable Flutter menu
" call FlutterMenu()

augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END

"One dark
"let g:onedark_config = {
    "\ 'style': 'warm',
"\}
"colorscheme onedark
"colorscheme tokyonight-moon
colorscheme zenburn
"colorscheme gruvbox
"colorscheme embark
"
"
" Palenight theme
"colorscheme palenight
"set background=dark
"let g:lightline = { 'colorscheme': 'palenight' }
"let g:airline_theme = "palenight"
"let g:palenight_terminal_italics=1
" End palenight theme
"
" Tokyo Night
"let g:tokyonight_italic_functions = 1
"let g:tokyonight_italic_variables = 1
"let g:tokyonight_style = "night"
"let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
"colorscheme tokyonight
" End tokyo night

if (has("termguicolors"))
    set termguicolors
endif

lua require'colorizer'.setup()

let mapleader = " "

let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
let NERDTreeMapOpenInTab='s'
let NERDTreeShowHidden=1
let g:NERDTreeGitStatusWithFlags = 1
nmap <leader>nt :NERDTreeToggle<CR>


nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>

nmap <leader>w :w<CR>
nmap <leader>q :bd<CR>


" Coc settings
"
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-json', 
  \ 'coc-flutter',
  \ 'coc-snippets',
  \ 'coc-yaml',
  \ 'coc-tslint-plugin',
  \ 'coc-tsserver',
  \ 'coc-emmet',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-htmldjango',
  \ 'coc-svelte',
  \ 'coc-python',
  \ 'coc-jedi',
  \ 'coc-go',
  "\ 'https://github.com/rodrigore/coc-tailwind-intellisense'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

imap <tab> <Plug>(coc-snippets-expand)
let g:UltiSnipsExpandTrigger = '<Nop>'
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use <c-space> to trigger completion.
if has('nvim')
  " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-x> <C-W>x

"nnoremap <leader>ff <cmd>Telescope git_files<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nmap <leader>vs :vs<CR>
nmap <leader>hs :split<CR>

" Use alt + hjkl to resize windows
"nnoremap ∆  :resize -2<CR>
"nnoremap ˚  :resize +2<CR>
"nnoremap ˙  :vertical resize -2<CR>
"nnoremap ¬  :vertical resize +2<CR>
nnoremap <A-k>  :resize -2<CR>
nnoremap <A-j>  :resize +2<CR>
nnoremap <A-h>  :vertical resize -2<CR>
nnoremap <A-l>  :vertical resize +2<CR>


" NerdCommenter Toggle remap to CTRL+/
vmap <C-_> <Plug>NERDCommenterToggle<cr>
nmap <C-_> <Plug>NERDCommenterToggle<cr>

" Barbar
lua require'barbar'.setup{}

" Disabling icons
"let bufferline = get(g:, 'bufferline', {})
"let bufferline.icons = v:true

" Dart
"let g:lsc_auto_map = v:true
"let g:flutter_autoscroll = 1
let g:dart_format_on_save = 1


" Flutter
"autocmd CompleteDone * silent! pclose
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <leader>fe :CocCommand flutter.emulators <CR>
nnoremap <leader>fr :CocCommand flutter.run <CR>
nnoremap <leader>fd :CocCommand flutter.devices<CR>
nnoremap <leader>fq :CocCommand flutter.dev.quit<CR>
nnoremap <leader>fvc :below vnew output:///flutter-dev <CR>
nnoremap <leader>fc :below new output:///flutter-dev <CR>

let g:embark_terminal_italics = 1

autocmd BufEnter *.{js,jsx,ts,tsx,svelte} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx,svelte} :syntax sync clear

nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>


"lua << EOF
"require'lspinstall'.setup()
"local servers = require'lspinstall'.installed_servers()
"for _, server in pairs(servers) do
  "require'lspconfig'[server].setup{}
"end
"EOF
"

" Svelte
let g:vim_svelte_plugin_use_typescript = 1

" Golang
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Flutter Snippets
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

lua << EOF
require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules"} } }
EOF
