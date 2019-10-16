#!/bin/sh

# install python3 (anaconda)
if [ ! -d ~/.anaconda3 ]; then
    echo "install anaconda3 ...."
    anaconda_installer="Anaconda3-2019.07-Linux-x86_64.sh"
    wget https://repo.anaconda.com/archive/$anaconda_installer -P ~/Downloads
    sh ~/Downloads/$anaconda_installer -b -p ~/.anaconda3
    rm ~/Downloads/$anaconda_installer
else
    echo "anaconda3 already exists."
fi

# zsh settings
if ! { cat /etc/shells | grep zsh > /dev/null 2>&1; } then
    echo "change default shell to zsh...."
    sudo apt-get install zsh
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
else
    echo "default shell is already set to zsh."
fi
ln -sf ~/.dotfiles/.zshrc ~/.zshrc

# install nvim
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
# neovim settings
if ! { conda env list | grep neovim > /dev/null 2>&1; } then
    echo "create conda env for neovim...."
    conda create --name neovim anaconda
    conda activate neovim
    conda install -c conda-forge neovim autopep8 flake8 flake8-import-order isort
    conda deactivate
else
    echo "conda neovim env already exists."
fi
ln -s ~/.dotfiles/nvim/ ~/.config/

# tmux settings
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

echo "finished."

