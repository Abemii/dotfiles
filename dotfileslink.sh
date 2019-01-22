#~/bin/sh
hn=$(hostname)
if [ `echo $hn | grep 'Mac'` ]; then
    ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
    # ln -sf ~/dotfiles/.zshrc ~/.zshrc
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
else
    ln -sf $EXT_HOME/dotfiles/nvim/config/ $EXT_HOME/.config/nvim 
    ln -sf $EXT_HOME/dotfiles/nvim/init.vim $EXT_HOME/.config/nvim 
    ln -sf $EXT_HOME/dotfiles/.bash_profile ~/.bash_profile
    ln -sf $EXT_HOME/dotfiles/.zshrc ~/.zshrc
    ln -sf $EXT_HOME/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf $EXT_HOME/dotfiles/.jupyter ~/
fi
