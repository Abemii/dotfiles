#~/bin/sh
hn=$(hostname)
if [ `echo $hn | grep 'Mac'` ]; then
    ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
else
    ln -sf ~/dotfiles/nvim/config/ 
fi
