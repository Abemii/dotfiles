#!/bin/bash

set -Ce

# ostype
IS_LINUX=false
IS_MAC=false
if [ "`uname`" == "Darwin" ]; then
    IS_MAC=true
    echo -e "\e[32mMac\e[m"
elif [ "`uname`" == "Linux" ]; then
    IS_LINUX=true
    echo -e "\e[32mLinux\e[m"
else
    echo -e "\e[31mFAIL\e[m"
    exit 1
fi

# check if you have sudo priviledge in linux
IS_SUDOER=false
if $IS_LINUX; then
    if `id $USER | grep "sudo" > /dev/null 2>&1`; then
        IS_SUDOER=true
        INSTALL_PATH="${HOME}/local"
        echo -e "\e[32mYou are sudoer.\e[m"
    else
        echo -e "\e[31mYou are not sudoer.\e[m"
    fi
fi

# install software
echo -e "\e[32mInstall software\e[m"

if $IS_MAC; then
    echo "Install homebrew"
    if ! { type brew > /dev/null 2>&1; }; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 
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
fi

if $IS_LINUX && $IS_SUDOER; then
    # to save yanked to clipboard in neovim
    if ! { type xclip > /dev/null 2>&1; } then
        sudp apt install -y xclip
    fi

    # for pbcopy alias
    if ! { type xsel > /dev/null 2>&1; } then
        sudp apt install -y xsel
    fi
fi


if $IS_MAC; then
    echo -e "\e[32mMac Global settings\e[m"
    ## no crash report
    defaults write com.apple.CrashReporter DialogType -string "none"

    ## no dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

    ## dock
    defaults write com.apple.dock autohide-delay -float 0

    ## screen capture
    defaults write com.apple.screencapture disable-shadow -bool true
    defaults write com.apple.screencapture type -string "png"
    if [ ! -d ~/Pictures/ScreenShots ]; then
        mkdir ~/Pictures/ScreenShots
    fi
    defaults write com.apple.screencapture location ~/Pictures/ScreenShots/
fi


function build_zsh_from_source () {
    INSTALL_DIR=$1

    # download ncurses
    mkdir -p tmp
    pushd tmp
        # install ncurses
        NCURSES_VERSION="6.2"
        wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz
        tar zxf ncurses-${NCURSES_VERSION}.tar.gz
        pushd ncurses-${NCURSES_VERSION}
            export CXXFLAGS=' -fPIC'
            export CFLAGS=' -fPIC'
            # mkdir build
            # pushd build
                ./configure --prefix=$INSTALL_DIR --enable-shared
                make
                make install
            # popd
        popd

        # install zsh
        ZSH_INSTALL_VERSION="5.7.1"
        wget -O zsh-${ZSH_INSTALL_VERSION}.tar.xz https://sourceforge.net/projects/zsh/files/zsh/${ZSH_INSTALL_VERSION}/zsh-${ZSH_INSTALL_VERSION}.tar.xz/download
        tar xf zsh-${ZSH_INSTALL_VERSION}.tar.xz
        pushd zsh-${ZSH_INSTALL_VERSION}
            # mkdir build
            # pushd build
                export PATH=$INSTALL_PATH/bin:$PATH
                export LD_LIBRARY_PATH=$INSTALL_PATH/lib:$LD_LIBRARY_PATH
                export CFLAGS=-I$INSTALL_PATH/include
                export CPPFLAGS=-I$INSTALL_PATH/include
                export LDFLAGS=-L$INSTALL_PATH/lib
                ./configure --prefix=$INSTALL_DIR --enable-shared
                make
                make install
            # popd
        popd
    popd
}


# install zsh and set as default shell
if ! { type zsh > /dev/null 2>&1; } then
    echo -e "\e[31mZSH is not installed. \e[32mInstall zsh....\e[m"
    if $IS_LINUX && $IS_SUDOER; then
        sudo apt install -y zsh
        echo "change default shell to zsh...."
        sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
    elif $IS_LINUX && ! $IS_SUDOER; then 
        build_zsh_from_source $INSTALL_PATH
        echo "change default shell to zsh...."
        echo "export SHELL=${INSTALL_PATH}/bin/zsh" >> ~/.bash_profile
        echo "exec ${INSTALL_PATH}/bin/zsh -l"      >> ~/.bash_profile
        export PATH="${INSTALL_PATH}/bin:$PATH"
    elif $IS_MAC; then
        brew install zsh
        echo "change default shell to zsh...."
        sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
    fi
fi

if { echo $SHELL | grep zsh > /dev/null 2>&1; } then
    echo -e "\e[32mdefault shell is set to zsh\e[m"
else
    echo -e "\e[31mdefault shell is not set to zsh. \e[32mset zsh as default\e[m"
    export SHELL=$(which zsh)
fi

# create symlink to zshrc
if [ ! -L ~/.zshrc ]; then
    echo -e "\e[32mcreate symbolic link to ~/.zshrc\e[m"
    ln -s $(pwd)/.zshrc ~/.zshrc
fi


# install nvim
echo -e "\e[32mInstall nvim\e[m"
if ! { type nvim > /dev/null 2>&1; } then
    if $IS_LINUX; then
        wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P $HOME
        chmod u+x $HOME/nvim.appimage
        alias nvim='eval $HOME/nvim.appimage'
    elif $IS_MAC; then
        brew install neovim
    fi
fi


# install python3 (anaconda)
echo -e "\e[32mInstall anaconda\e[m"
conda_dst="~/anaconda3"
if [ ! -d $conda_dst ]; then
    echo "install anaconda3 ...."
    if $IS_MAC; then
        anaconda_installer="Anaconda3-2019.07-MacOSX-x86_64.sh"
    elif $IS_LINUX; then
        anaconda_installer="Anaconda3-2019.07-Linux-x86_64.sh"
    fi
    wget https://repo.anaconda.com/archive/$anaconda_installer -P tmp
    bash tmp/$anaconda_installer -b -p $conda_dst

    echo "update conda ...."
    export PATH=$conda_dst/bin:$PATH
    conda update -y -n base -c defaults conda
else
    echo "anaconda3 already exists."
fi


# neovim settings
echo -e "\e[32mSetup nvim\e[m"

if ! { conda env list | grep neovim > /dev/null 2>&1; } then
    echo "create conda env for neovim...."
    conda create -y --name neovim python=3.8
    source activate neovim
    conda install -y -c conda-forge neovim jedi flake8 isort black
    conda deactivate
else
    echo "conda neovim env already exists."
fi

echo "create symbolic link to ~/.config/nvim" 
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

if [ ! -L ~/.config/nvim ]; then
    ln -s ~/.dotfiles/nvim/ ~/.config/
fi

echo "PlugInstall"
nvim +PlugInstall +qa

function build_ctags_from_source () {
    INSTALL_DIR=$1

    mkdir -p tmp
    pushd tmp
        # install ctags
        CTAGS_VERSION="5.8"
        wget http://prdownloads.sourceforge.net/ctags/ctags-${CTAGS_VERSION}.tar.gz
        tar zxf ctags-${CTAGS_VERSION}.tar.gz
        pushd ctags-${CTAGS_VERSION}
            # mkdir build
            # pushd build
                ./configure --prefix=$INSTALL_DIR
                make
                make install
            # popd
        popd
    popd
}


echo "install ctags for majutsushi/tagbar"
if ! { type ctags > /dev/null 2>&1; } then
    if $IS_LINUX && $IS_SUDOER; then
        sudo apt install -y exuberant-ctags
    elif $IS_LINUX && ! $IS_SUDOER; then
        build_ctags_from_source $INSTALL_PATH
    elif $IS_MAC; then
        brew install ctags
    fi
fi


function build_tmux_from_source () {
    INSTALL_DIR=$1

    mkdir -p tmp
    pushd tmp
        # install openssl
        OPENSSL_VERSION="1.1.1c"
        wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
        tar zxf openssl-${OPENSSL_VERSION}.tar.gz
        pushd openssl-${OPENSSL_VERSION}
            # mkdir build
            # pushd build
                ./config --prefix=$INSTALL_DIR --openssldir=$INSTALL_DIR shared
                make
                make install
            # popd
        popd

        # install libevent
        LIBEVENT_VERSION="2.1.12-stable"
        wget https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz --no-check-certificate
        tar zxf libevent-${LIBEVENT_VERSION}.tar.gz
        pushd libevent-${LIBEVENT_VERSION}
            # mkdir build
            # pushd build
                ./configure --prefix=$INSTALL_DIR
                make
                make install
            # popd
        popd

        # install tmux
        TMUX_VERSION="3.1b"
        wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz --no-check-certificate
        tar zxf tmux-${TMUX_VERSION}.tar.gz
        pushd tmux-${TMUX_VERSION}
            # mkdir build
            # pushd build
               CFLAGS="-I/${INSTALL_DIR}/include/ncurses $CFLAGS"
               ./configure --prefix=$INSTALL_DIR
               make
               make install
            # popd
        popd
    popd
}

# tmux settings
echo -e "\e[32mInstall tmux\e[m"
if ! { type tmux > /dev/null 2>&1; } then
    if $IS_LINUX && $IS_SUDOER; then
        sudo apt install tmux
    elif $IS_LINUX && ! $IS_SUDOER; then
        build_tmux_from_source $INSTALL_PATH
    elif $IS_MAC; then
        brew install tmux
    fi
fi

echo -e "\e[32mSetup tmux\e[m"
echo "create symbolic link to ~/.tmux.conf" 
if [ ! -L ~/.tmux.conf ]; then
    ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
fi


echo -e "\e[32mFinished\e[m"

