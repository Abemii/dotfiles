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

## Remote

### Copy files from docker container to host

```bash
docker run -it --rm ubuntu:22.04

# container
apt-get update
apt-get install -y silversearcher-ag universal-ctags

# host
mkdir -p bin/../lib/x86_64-linux-gnu
docker cp <container>:/usr/bin/rg bin/
docker cp <container>:/usr/bin/ctags-universal bin/

# dependencies
docker cp <container>:/usr/lib/x86_64-linux-gnu/libpcre.so.3 lib/x86_64-linux-gnu
docker cp <container>:/usr/lib/x86_64-linux-gnu/libpcre.so.3.13.3 lib/x86_64-linux-gnu
```

### Copy files to remote server

```bash
rsync -avzPR .././dotfiles/{setup_remote_nvim.sh,bin,lib} <server>:
# pre-installed plugins
rsync -avzPR ~/./.local/share/nvim/plugged <server>:
rsync -avzPR nvim <server>:.config/
```

### Setup on remote server

```bash
cd dotfiles
./setup_remote_nvim.sh
```

### Install `jedi-language-server` for CoC.nvim

example using `python3.12-venv`:

```bash
sudo apt-get update && sudo apt-get install python3.12-venv
python3 -m venv ~/.jedi-language-server
source ~/.jedi-language-server/bin/activate
pip install jedi-language-server
ln -s ~/.jedi-language-server/bin/jedi-language-server ~/.local/bin/jedi-language-server
deactivate
```

example using `uv`

```bash
uv venv ~/.jedi-language-server
. ~/.jedi-language-server/bin/activate
uv pip install jedi-language-server
ln -s ~/.jedi-language-server/bin/jedi-language-server ~/.local/bin/jedi-language-server
deactivate
```
