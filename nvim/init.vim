filetype off

" auto-install vim-plug
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let config_nvim_path=$HOME.'/.config/nvim/'
let plugged_path=config_nvim_path.'plugged'
set rtp+=plugged_path

set runtimepath+=config_nvim_path
runtime! base.vim
runtime! plug.vim
runtime! cfgs/*.vim

filetype plugin indent on

