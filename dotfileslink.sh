#~/bin/sh
hn=$(hostname)
if [ `echo $hn | grep 'Mac'` ]; then
    ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
    ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
elif [ `echo $hn | grep 'hpc'` ]; then
    ln -sf $EXT_HOME/dotfiles/nvim/config/ $EXT_HOME/.config/nvim 
    ln -sf $EXT_HOME/dotfiles/zsh/.zshrc $EXT_HOME/.zshrc
fi
