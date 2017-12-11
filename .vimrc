set nocompatible
" let g:loaded_netrw=1
set tags=tags;/
:colo evening
syntax on
set number
set hlsearch
set autoindent
" set smartindent
set cindent
set expandtab
set shiftwidth=4
set softtabstop=4
" set textwidth=119
set cindent
set cino=(0,t0,c5,C5,p0,=0
nnoremap <silent> _] :Lid <C-R><C-W><CR>
nnoremap <silent> _} :Lid <C-R><C-W><CR>
nnoremap <silent> <F4> :!dirs_list="./"; ctags -R $dirs_list; temp_files_list=`mktemp id_files_list_XXX`; find $dirs_list -name "*.cpp" -print0 -or -name "*.c" -print0 -or -name "*.cc" -print0 -or -name "*.[shS]" -print0 > $temp_files_list; mkid -o ID --files0-from=$temp_files_list; rm $temp_files_list; <CR><CR>
 
cnoremap sudow w !sudo tee % >/dev/null
set path=$PWD/**
:set listchars=tab:>-,trail:~,extends:>,precedes:<
:set list
set colorcolumn=120

map <F1> :execute "vimgrep /" . expand("<cword>") . "/j **/*.cpp **/*.h" <Bar> cw<CR>

vnoremap // y/<C-R>"<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

set complete-=i

"clang_autocomplete options
"set conceallevel=2
"set concealcursor=vin
"set completeopt=menuone,menu
" Complete shortcuts
"imap <C-Space> <C-X><C-U>
"imap <Nul> <C-X><C-U>
"let g:clang_use_library=1
"let g:clang_library_path='/usr/lib/llvm-3.8/lib'
"let g:clang_complete_auto=1
"let g:clang_periodic_quickfix=1
"let g:clang_snippets=1
"let g:clang_conceal_snippets=1
"let g:clang_snippets_engine='clang_complete'
" Show clang errors in the quickfix window
"let g:clang_complete_copen = 1
"set completeopt=longest,menuone,preview
"let g:clang_c_options = '-std=gnu11'
"let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'

command! E Explore
