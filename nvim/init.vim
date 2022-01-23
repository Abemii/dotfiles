filetype off

let config_nvim_path = $XDG_CONFIG_HOME . '/nvim'

" auto-install vim-plug
if empty(glob(config_nvim_path . '/autoload/plug.vim'))
  silent !curl -fLo config_nvim_path . '/autoload/plug.vim' --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let plugged_path = config_nvim_path . '/plugged'

ru base.vim
ru plug.vim
ru! cfgs/*.vim

filetype plugin indent on
