#~/bin/sh
hn=$(hostname)
if [ `echo $hn | grep 'Mac'` ]; then
    ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
    # ln -sf ~/dotfiles/.zshrc ~/.zshrc
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
elif [ `echo $hn | grep -e 'hpc.vpl.nii.ac.jp' -e 'dgx1'` ]; then
#deleted
    ln -sf $EXT_HOME/dotfiles/nvim/config/ $EXT_HOME/.config/nvim 
#deleted
#deleted
#deleted
#deleted
# elif [ `echo $hn | grep 'ubuntu'` ]; then
#     ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
#     ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
#     ln -sf ~/dotfiles/.zshrc ~/.zshrc
#     ln -sf ~/dotfiles/.jupyter ~/
fi
