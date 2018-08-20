#~/bin/sh
hn=$(hostname)
if [ `echo $hn | grep 'Mac'` ]; then
    ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
    ln -sf ~/dotfiles/.zshrc ~/.zshrc
elif [ `echo $hn | grep 'hpc.vpl.nii.ac.jp'` ]; then
    ln -sf $EXT_HOME/dotfiles/nvim/config/ $EXT_HOME/.config/nvim 
    ln -sf $EXT_HOME/dotfiles/.bash_profile ~/.bash_profile
    ln -sf $EXT_HOME/dotfiles/.zshrc ~/.zshrc
    ln -sf $EXT_HOME/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf $EXT_HOME/dotfiles/.jupyter ~/
elif [ `echo $hn | grep 'ubuntu'` ]; then
    ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/.zshrc ~/.zshrc
    ln -sf ~/dotfiles/.jupyter ~/
fi
