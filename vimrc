" Mon fichier de configuration pour vim "
" ##################################### "
"
    let g:BASH_AuthorName   = 'Totom'
    let g:BASH_AuthorRef    = 'Mr'
    let g:BASH_Email        = 'thomas@courbeil.org'
    let g:BASH_Company      = 'courbeil-informatique'
"
" Activation de la coloration
syntax on

" Couleurs de vim
"colorscheme elflord
colorscheme koehler

" Nettoyage des fichiers
" Les tabulations en espaces
" Remplace les ^M par des fin de ligne
function! CleanCode()
    %retab
    %s/^M//g
    call s:DisplayStatus ('Code nettoyé')
endfunction

" Autocomplementation
function! MultipleAutoCompletion()
    if &omnifunc != ''
        return "\<C-x>\<C-o>"
    elseif &dictionary !=''
        return "\<C-x>\<C-k>"
        else
        return "\<C-x>\<C-n>"
    endif
endfunction

" fonction de pliage
function! MyFoldFunction()
    let line = getline(v:foldstart)
    let sub = substitute(line, '/\*\|\*/\|^\s+', '', 'g')
    let lines = v:foldend - v:foldstart + 1
    return '[+]'. v:folddashes.sub . '...' . lines . ' lignes...' . getline(v:foldend)
endfunction

" ouverture et fermeture des plis
set foldenable
" affichage de = sur la ligne de pliage
set fillchars=fold:=
" definition de l'affichage du pliage
set foldtext=MyFoldFunction()


" Let unixx format, utf8, see line number... etc...
set fileformat=unix
set encoding=utf-8
set number
syn on
set nocompatible

"My prefered values :)
set shiftwidth=4
set tabstop=4
set nowrapscan
set ignorecase
set expandtab
set showtabline=2
set foldmethod=marker
set hlsearch


"Use mouse... comment this if you don't like
"set mouse=a


" autocommads on php files
set complete=.,w,b,u,t,i,k~/.vim/syntax/php.api
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
source ~/.vim/plugin/word_complete.vim
call DoWordComplete()

" <Leader> is "\"... but on azerty keyboard it better to use "," wich is more accessible
:let mapleader = ","

"Use Project"
runtime! ~/.vim/plugin/Project.vim


" Create tags with '\1' command
function! Phptags()   
    "change exclude for your project, here it's a good exclude for Copix temp and var files"
    let cmd = '!ctags -f .tags -h ".php" -R --exclude="\.svn" --exclude="./var" --exclude="./temp" --totals=yes --tag-relative=yes'
    exec cmd
    set tags=.tags
endfunction
:let g:proj_run1='call Phptags()'

"to remap \1 on ,1
nmap ,1 \1

" F9 will do a PHP lint !
set makeprg = "php -l %"
nmap <F9> :make<ENTER>:copen<ENTER><CTRL>L


" \2 on project view will svn update current directory
:let g:proj_run2='!svn ci %R'

" \5 on project view will commit current directory
:let g:proj_run5='!svn up %R'

" Les raccourcies claviers
map   <silent> <F2>    :write<CR>
map   <silent> <F3>    :Explore<CR>
nmap  <silent> <F4>    :exe ":ptag ".expand("<cword>")<CR>
map   <silent> <F6>    :copen<CR>
map   <silent> <F7>    :cp<CR>
map   <silent> <F8>    :cn<CR>
map   <silent> <F12>   :let &number=1-&number<CR>
"
imap  <silent> <F2>    <Esc>:write<CR>
imap  <silent> <F3>    <Esc>:Explore<CR>
imap  <silent> <F4>    <Esc>:exe ":ptag ".expand("<cword>")<CR>
imap  <silent> <F6>    <Esc>:copen<CR>
imap  <silent> <F7>    <Esc>:cp<CR>
imap  <silent> <F8>    <Esc>:cn<CR>
imap  <silent> <F12>   <Esc>:let &number=1-&number<CR>

"Activation des snippet
:filetype plugin on

" Pour les fichiers Arduino
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" Coloration fichier yaml 
 au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/syntax/yaml.vim
