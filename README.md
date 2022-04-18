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
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/tmux.conf ~/.tmux.conf
```

## nvim

- CoC

In nvim,

```
CocInstall coc-json coc-python coc-highlight
```

## zsh

## tmux

## NVIDIA

### Ubuntu 20.04

- nvidia-driver

GUI: Software & Updates -> Additional Drivers -> NVIDIA Corporation: xx

- cuda-toolkit

Install CUDA10.1

```bash
sudo apt install nvidia-cuda-toolkit
```

## Docker

Create zsh + neovim env in the project docker container.

### build

```bash
docker build -t neovim docker --build-arg JOBS=4 --build-arg MAINTAINER="abemii"
```

### run

```bash
docker run -it --rm --net host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/root/.Xauthority -e HOME=/root -v $HOME:$HOME -w $PWD -u $(id -u):$(id -g) -v /etc/passwd:/etc/passwd:ro neovim
```
