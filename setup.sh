#!/bin/bash

set -Ceu

# ostype
ISLINUX=false
ISMAC=false
if [ "`uname`" == "Darwin" ]; then
    ISMAC=true
    echo -e "\e[32mMac\e[m"
elif [ "`uname`" == "Linux" ]; then
    ISLINUX=true
    echo -e "\e[32mLinux\e[m"
else
    echo -e "\e[31mFAIL\e[m"
    exit 1
fi

# install software
echo -e "\e[32mInstall software\e[m"

if $ISMAC; then
    echo "Install homebrew"
    if ! { type brew > /dev/null 2>&1; }; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    echo "Install cask"
    if ! { brew list | grep cask > /dev/null 2>&1; } then
        brew install cask
    fi

    echo "Install mas"
    if ! { type mas > /dev/null 2>&1; } then
        brew install mas
    fi

    echo "Install coreutils"
    if ! { brew list | grep coreutils > /dev/null 2>&1; } then
        brew install coreutils
    fi

    echo "Install wget"
    if ! { type wget > /dev/null 2>&1; } then
        brew install wget
    fi

    echo "Install htop"
    if ! { type htop > /dev/null 2>&1; } then
        brew install htop
    fi

    echo "Install iterm2"
    if ! { brew cask list | grep iterm2 > /dev/null 2>&1; } then
        brew cask install iterm2
    fi

    echo "Install ricty font"
    if ! { brew list | grep ricty > /dev/null 2>&1; } then
        brew tap sanemat/font
        brew install ricty
    fi

    echo "Install imagemagick"
    if ! { brew list | grep imagemagick > /dev/null 2>&1; } then
        brew install imagemagick
    fi

    echo "Install firefox"
    if [ ! -d "/Applications/Firefox.app" ]; then
        brew cask install firefox
    fi

    echo "Install slack"
    if [ ! -d "/Applications/Slack.app" ]; then
        brew cask install slack
    fi

    echo "Install google-japanese-ime"
    if ! { brew cask list | grep google-japanese-ime > /dev/null 2>&1; } then
        brew cask install google-japanese-ime
    fi

    echo "Install scroll-reverser"
    if ! { brew cask list | grep scroll-reverser > /dev/null 2>&1; } then
        brew cask install scroll-reverser
    fi

    echo "Install libreoffice"
    if [ ! -d "/Applications/LibreOffice.app" ]; then
        brew cask install libreoffice
    fi

    echo "Install karabiner-elements"
    if ! { brew cask list | grep karabiner-elements > /dev/null 2>&1; } then
        brew cask install karabiner-elements
    fi

    echo "Install skype"
    if [ ! -d "/Applications/Skype.app" ]; then
        brew cask install skype
    fi

    echo "Install dropbox"
    if [ ! -d "/Applications/Dropbox.app" ]; then
        brew cask install dropbox
    fi

    echo "Install magnet (id: 441258766)"
    if [ ! -d "/Applications/Magnet.app" ]; then
        mas install 441258766
    fi

    echo "Install autossh"
    if ! { type autossh > /dev/null 2>&1; } then
        brew install autossh
    fi

    echo "Install gimp"
    if [ ! -d "/Applications/GIMP-2.10.app" ]; then
        brew cask install gimp
    fi

    echo "Install ip"
    if ! { type ip > /dev/null 2>&1; } then
        brew install iproute2mac
    fi

    echo "Install bitwarden"
    if [ ! -d "/Applications/Bitwarden.app" ]; then
        brew cask install bitwarden
    fi

    echo "Install nkf"
    if ! { type nkf > /dev/null 2>&1; } then
        brew install nkf
    fi

    echo "Install uplatex"
    if ! { type uplatex > /dev/null 2>&1; } then
        brew cask install mactex-no-gui
        sudo tlmgr update --self --all
        sudo tlmgr paper a4
    fi
fi

echo -e "\e[32mGlobal settings\e[m"

if ISMAC; then
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
    fi
    defaults write com.apple.screencapture location ~/Pictures/ScreenShots/
fi


# install python3 (anaconda)
echo -e "\e[32mInstall anaconda\e[m"
conda_dst="~/.anaconda3"
if $ISMAC; then
    anaconda_installer="Anaconda3-2019.07-MacOSX-x86_64.sh"
elif $ISLINUX; then
    anaconda_installer="Anaconda3-2019.07-Linux-x86_64.sh"
fi
if [ ! -d $conda_dst ]; then
    echo "install anaconda3 ...."
    wget https://repo.anaconda.com/archive/$anaconda_installer -P ~/tmp
    sh ~/tmp/$anaconda_installer -b -p ~/.anaconda3
    rm ~/tmp/$anaconda_installer
else
    echo "anaconda3 already exists."
fi


# install zsh and set as default shell
echo -e "\e[32mInstall zsh\e[m"
if { echo $SHELL | grep zsh > /dev/null 2>&1; } then
    echo "default shell is set to zsh".
else
    if ! { cat /etc/shells | grep zsh > /dev/null 2>&1; } then
        echo "zsh is not installed. install zsh"
        if $ISLINUX; then
            sudo apt install zsh
        elif $ISMAC; then
            brew install zsh
        fi
    fi
    echo "change default shell to zsh...."
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
fi

echo "create symbolic link to ~/.zshrc" 
ln -s $(pwd)/.zshrc ~/.zshrc
source ~/.zshrc

# install nvim
echo -e "\e[32mInstall nvim\e[m"
if ! { type nvim > /dev/null 2>&1; } then
    if $ISLINUX; then
        wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P $HOME
        chmod u+x $HOME/nvim.appimage
    elif $ISMAC; then
        brew install neovim
    fi
fi

# neovim settings
echo -e "\e[32mSetup nvim\e[m"

if ! { conda env list | grep neovim > /dev/null 2>&1; } then
    echo "create conda env for neovim...."
    conda create --name neovim python=3.8
    source activate neovim
    conda install -c conda-forge neovim jedi flake8 isort black
    conda deactivate
else
    echo "conda neovim env already exists."
fi

echo "create symbolic link to ~/.config/nvim" 
ln -s ~/.dotfiles/nvim/ ~/.config/

echo "install ctags for majutsushi/tagbar"
if ! { type ctags > /dev/null 2>&1; } then
    if $ISLINUX; then
        sudo apt install -y exuberant-ctags
    elif $ISMAC; then
        brew install ctags
    fi
fi

echo "PlugInstall"
nvim +PlugInstall +qa

# tmux settings
echo -e "\e[32mInstall tmux\e[m"
if ! { type tmux > /dev/null 2>&1; } then
    if $ISLINUX; then
        sudo apt install tmux
    elif $ISMAC; then
        brew install tmux
    fi
fi

echo -e "\e[32mSetup tmux\e[m"
echo "create symbolic link to ~/.tmux.conf" 
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf


echo -e "\e[32mFinished\e[m"

