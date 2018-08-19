#~/bin/sh
hn=$(hostname)
if [ `echo $hn | grep 'Mac'` ]; then
    ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
    ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
elif [ `echo $hn | grep 'hpc.vpl.nii.ac.jp'` ]; then
    ln -sf $EXT_HOME/dotfiles/nvim/config/ $EXT_HOME/.config/nvim 
fi
