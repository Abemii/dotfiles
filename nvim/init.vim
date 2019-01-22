" auto-install vim-plug
if empty(glob('$EXT_HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo $EXT_HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let config_nvim_path='$EXT_HOME/.config/nvim/'
let plugged_path=join([config_nvim_path,'plugged'],'')
set rtp+=plugged_path


set nocompatible
filetype off
set hidden
set showtabline=0


set runtimepath+=config_nvim_path
runtime! config/init/editor.vim
runtime! config/init/plugins.vim
runtime! config/plugins-config/*.vim

filetype plugin indent on

