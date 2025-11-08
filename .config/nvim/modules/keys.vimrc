
let mapleader = " "

"<c-q> for escaping insert and visual modes inoremap <c-q> <esc> vnoremap <c-q> <esc>
inoremap <c-q> <esc>
vnoremap <c-q> <esc>

"uhhh you can read
nnoremap ; :

"moving around with htns in normal and visual modes
nnoremap s l
nnoremap n j
nnoremap t k
nnoremap l I
xnoremap s l
xnoremap n j
xnoremap t k
xnoremap l I

" --- Insert / append keys ---
" e → insert at cursor
nnoremap e i
" E → append after cursor
nnoremap E a
" i / I kept for normal Vim insert at line start
nnoremap i e

"jump to first non-blank character (smart line start)
nnoremap I ^
xnoremap I ^

" --- Visual & Normal Clipboard Integration ---
"secondary clipboard eh you know it
xnoremap <c-c> "+ygv
" Cut to system clipboard (Visual)
xnoremap <C-x> "+d
"<c-v> for pasting text from the clipboard in insert mode
inoremap <C-v> <C-r>+
nnoremap <C-v> "+p
" Normal-mode copy/cut (no visual exit)
nnoremap <C-c> "+yy
nnoremap <C-x> "+dd

"to recover undo states in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"<c-a> to select all
nnoremap <C-a> ggVG

"k for pasting
nnoremap k p
nnoremap K P
xnoremap k p
xnoremap K P

" --- Search navigation ---
" j → next result, J → previous
nnoremap j n
nnoremap J N
nnoremap N J
xnoremap j n
xnoremap J N
xnoremap N J

" --- Undo / redo / replace ---
nnoremap U <C-r>
nnoremap <C-r> R

" --- Numeric increment / decrement ---
nnoremap <leader>. :normal! <C-a><CR>
nnoremap <leader>, :normal! <C-x><CR>

" --- Split window management ---
" Vertical / horizontal splits (focus new split)
nnoremap <leader>v :vsplit<CR><C-w>w
nnoremap <leader>h :split<CR><C-w>w

" --- Tab management ---
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<CR>

" --- Quote / bracket wrappers ---
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>hbi[<esc>lel

" --- Sudo write (NixOS pkexec) ---
"cnoremap :w!! :w !pkexec tee % >/dev/null

" --- Backspace disabled in normal mode ---
nnoremap <BS> <Nop>
nnoremap <Space> <Nop>
xnoremap <Space> <Nop>
onoremap <Space> <Nop>

"Q to reformat paragraphs
vnoremap Q gq
nnoremap Q gqap

nnoremap p *
nnoremap P #
