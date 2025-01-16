" 显示 relative line number
set number
set relativenumber
set clipboard=unnamedplus 

imap jk <Esc>

" helpgrep shortcut
nmap <silent> <RIGHT>            :cnext<CR>
nmap <silent> <RIGHT><RIGHT>     :cnfile<CR><C-G>
nmap <silent> <LEFT>             :cprev<CR>
nmap <silent> <LEFT><LEFT>       :cpfile<CR><C-G>

" highlight search
set hlsearch
nmap <silent>  <BS>  :nohlsearch<CR>

" persistent undo history
