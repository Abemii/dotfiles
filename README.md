# dotfiles

## setup

```bash
# clone repository
git clone git@github.com:Abemii/dotfiles.git
cd dotfiles

# install dependencies
# warning: this if for initial environment creation
# ./setup.sh

# create symboliclink
ln -s $(pwd)/nvim/config/ ~/.config/nvim 
ln -s $(pwd)/nvim/init.vim ~/.config/nvim 
ln -s $(pwd)/.zshrc ~/.zshrc
```

## nvim

- CoC

In nvim,

```
CocInstall coc-json coc-python
```

## zsh

## tmux
