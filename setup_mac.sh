#!/bin/sh

# install softwares

## install homebrew
if ! { type brew > /dev/null 2>&1; }; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

## install cask
if ! { brew list | grep cask > /dev/null 2>&1; } then
    brew install cask
fi

## install mas
if ! { type mas > /dev/null 2>&1; } then
    brew install mas
fi

## install coreutils
if ! { brew list | grep coreutils > /dev/null 2>&1; } then
    brew install coreutils
fi

## install wget
if ! { type wget > /dev/null 2>&1; } then
    brew install wget
fi

## install htop
if ! { type htop > /dev/null 2>&1; } then
    brew install htop
fi

## install iterm2
if ! { brew cask list | grep iterm2 > /dev/null 2>&1; } then
    brew cask install iterm2
fi

## install neovim
if ! { type nvim > /dev/null 2>&1; } then
    brew install neovim
fi

## install tmux
if ! { type tmux > /dev/null 2>&1; } then
    brew install tmux
fi

## install ricty font
if ! { brew list | grep ricty > /dev/null 2>&1; } then
    brew tap sanemat/font
    brew install ricty
fi

## install imagemagick
if ! { brew list | grep imagemagick > /dev/null 2>&1; } then
    brew install imagemagick
fi

## install firefox
if [ ! -d "/Applications/Firefox.app" ]; then
    brew cask install firefox
fi

## install slack
if [ ! -d "/Applications/Slack.app" ]; then
    brew cask install slack
fi

## install google-japanese-ime
if ! { brew cask list | grep google-japanese-ime > /dev/null 2>&1; } then
    brew cask install google-japanese-ime
fi

## install scroll-reverser
if ! { brew cask list | grep scroll-reverser > /dev/null 2>&1; } then
    brew cask install scroll-reverser
fi

## install libreoffice
if [ ! -d "/Applications/LibreOffice.app" ]; then
    brew cask install libreoffice
fi

## install karabiner-elements
if ! { brew cask list | grep karabiner-elements > /dev/null 2>&1; } then
    brew cask install karabiner-elements
fi

## install skype
if [ ! -d "/Applications/Skype.app" ]; then
    brew cask install skype
fi

## install dropbox
if [ ! -d "/Applications/Dropbox.app" ]; then
    brew cask install dropbox
fi

## install magnet (id: 441258766)
if [ ! -d "/Applications/Magnet.app" ]; then
    mas install 441258766
fi

## install autossh
if ! { type autossh > /dev/null 2>&1; } then
    brew install autossh
fi

## install gimp
if [ ! -d "/Applications/GIMP-2.10.app" ]; then
    brew cask install gimp
fi

## install ip
if ! { type ip > /dev/null 2>&1; } then
    brew install iproute2mac
fi

## install bitwarden 
if [ ! -d "/Applications/Bitwarden.app" ]; then
    brew cask install bitwarden
fi

## install nkf
if ! { type nkf > /dev/null 2>&1; } then
    brew install nkf
fi

## install uplatex
if ! { type uplatex > /dev/null 2>&1; } then
    brew cask install mactex-no-gui
    sudo tlmgr update --self --all
    sudo tlmgr paper a4
fi


# MacOS settings

## global settings
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSInitialToolTipDelay -integer 0
defaults write -g NSWindowResizeTime 0.1

defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain com.apple.springing.delay -float 0
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

## no crash report
defaults write com.apple.CrashReporter DialogType -string "none"

## no dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

## do not create .ds_store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

## dock
defaults write com.apple.dock autohide-delay -float 0

## finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder AnimateWindowZoom -bool false
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.Finder QuitMenuItem -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false

## screen capture
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "png"
if [ ! -d ~/Pictures/ScreenShots ]; then
    mkdir ~/Pictures/ScreenShots
defaults write com.apple.screencapture location ~/Pictures/ScreenShots/


# install python3 (anaconda)
if [ ! -d ~/.anaconda3 ]; then
    echo "install anaconda3 ...."
    anaconda_installer="Anaconda3-2019.07-MacOSX-x86_64.sh"
    wget https://repo.anaconda.com/archive/$anaconda_installer -P ~/Downloads
    sh ~/Downloads/$anaconda_installer -b -p ~/.anaconda3
    rm ~/Downloads/$anaconda_installer
else
    echo "anaconda3 already exists."
fi

# zsh settings
if ! { cat /etc/shells | grep /usr/local/bin/zsh > /dev/null 2>&1; } then
    echo "change default shell to zsh...."
    brew install zsh
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
else
    echo "default shell is already set to zsh."
fi
ln -sf ~/.dotfiles/zshrc_mac ~/.zshrc

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

echo "finished."

