call plug#begin('~/.config/nvim/plugged')

" Case Conversion and more!
Plug 'tpope/vim-abolish'

" Multi-Cursor
Plug 'mg979/vim-visual-multi'

" Comments!
Plug 'scrooloose/nerdcommenter'

" Change surrounding
Plug 'tpope/vim-surround'

" Git stuff (2)
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Rust-vim
Plug 'rust-lang/rust.vim'

" FZF (fuzzy searching)
let $FZF_DEFAULT_COMMAND = 'rg --files'
let $FZF_DEFAULT_OPTS='--reverse' 
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.9 } }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" For awesome snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories = ['/users/bhalsted/.config/nvim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
" defaults to c-j and c-k
let g:UltiSnipsJumpForwardTrigger="<c-h>"
let g:UltiSnipsJumpBackwardTrigger="<c-t>"
let g:UltiSnipsEditSplit="vertical"
" Common language snippets
Plug 'honza/vim-snippets'


" The status bar
Plug 'itchyny/lightline.vim'
let g:lightline = { 
      \  'colorscheme': 'challenger_deep',
      \  'active': {
      \    'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified', 'cocstatus', 'gitbranch']],
      \  },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'FugitiveHead',
      \ }
      \}

" " The status bar                                                                                                          
" Plug 'vim-airline/vim-airline'                                                                                            
" Plug 'vim-airline/vim-airline-themes'

" Cool color theme
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

" For editing markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" For GDScript syntax highlight
Plug 'calviken/vim-gdscript3'

call plug#end()

set nowrap
set encoding=utf-8
set termencoding=utf-8
set termguicolors

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" For line numbers in the gutter (easy 15j 13k jumping)
"set relativenumber
set number
"set number relativenumber

" So that gutter markers appear quicker
set updatetime=100

set ignorecase
set cursorline

syntax on

colorscheme challenger_deep

inoremap c. <ESC>:w<CR>
nnoremap c. <ESC>:w<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,f :Files<CR>
nnoremap ,s :BLines<CR>
nnoremap ,l :Lines<CR>
nnoremap ,m :Marks<CR>
nnoremap ,a :Ag<CR>
nnoremap ,r :Rg<CR>
nnoremap ,qo :copen<CR>
nnoremap ,qn :cnext<CR>
nnoremap ,qp :cprev<CR>
nnoremap ,qq :cclose<CR>
nnoremap ,lo :lopen<CR>
nnoremap ,ln :lnext<CR>
nnoremap ,lp :lprev<CR>
nnoremap ,lq :lclose<CR>
"nmap <F8> :TagbarToggle<CR>


" delete the current buffer, but not the split
nmap ,d :b#<bar>bd#<CR>

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" ============== COC Example Config
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Rust-fmt
let g:rustfmt_autosave = 1
