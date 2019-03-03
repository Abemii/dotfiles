filetype off
" auto-install vim-plug
" variable EXT_HOME is set to file server home directory.
if empty(glob('$EXT_HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo $EXT_HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let config_nvim_path='$EXT_HOME/.config/nvim/'
let plugged_path=join([config_nvim_path,'plugged'],'')
set rtp+=plugged_path

set runtimepath+=config_nvim_path
runtime! config/init/editor.vim
runtime! config/init/plugins.vim
runtime! config/plugins-config/*.vim

filetype plugin indent on

