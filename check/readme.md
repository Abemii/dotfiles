## Test neovim in the container

```bash
# host
./test_nvim_container.sh

# container
cd ~/dotfiles
./setup_nvim.sh

# set environment variables manually

nvim
```

## Test bash in the container

```bash
# host
./test_nvim_container.sh

# container
cd ~/dotfiles
source bashrc.local

<C-r>  # fzf: show recent commands
```

## Test zsh in the container

```bash
# host
./test_nvim_container.sh

# container
cd ~/dotfiles
./setup_zsh.sh

zsh
```
