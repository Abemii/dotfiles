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
ln -s $(pwd)/nvim ~/.config
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
```

## nvim

- CoC

In nvim,

```
CocInstall coc-json coc-python
```

## zsh

## tmux
