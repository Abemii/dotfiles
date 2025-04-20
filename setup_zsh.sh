#!/usr/bin/env bash

set -euo pipefail -C

echoI() {
    echo -e "\e[32m$1\e[m"
}

echoE() {
    echo -e "\e[31m$1\e[m"
}

TMP_DIR=$(mktemp -d)
NJOBS=${NJOBS:-5}
GNU_MIRROR="https://ftp.jaist.ac.jp/pub/GNU"

export INSTALL_DIR="${HOME}/.local"
mkdir -p ${INSTALL_DIR}/bin
export PATH="${INSTALL_DIR}/bin:$PATH"

export SCRIPT_DIR=$(dirname $(realpath $0))

# check if you have sudo priviledge in linux
IS_SUDOER=false
if $(sudo -l -U $USER >/dev/null 2>&1); then
    IS_SUDOER=true
    echoI "You are sudoer."
else
    echoE "You are not sudoer."
fi

# update apt
if $IS_SUDOER; then
    sudo apt update
fi

# ---------------------------------------------------
# install zsh
# ---------------------------------------------------

# build zsh from source (with local ncurses)
build_zsh_from_source() {
    echoI "Installing ncurses locally"
    NCURSES_VERSION="6.2"
    wget -O "${TMP_DIR}/ncurses-${NCURSES_VERSION}.tar.gz" -nc "${GNU_MIRROR}/ncurses/ncurses-${NCURSES_VERSION}.tar.gz"
    tar zxf "${TMP_DIR}/ncurses-${NCURSES_VERSION}.tar.gz" -C "${TMP_DIR}"
    pushd "${TMP_DIR}/ncurses-${NCURSES_VERSION}"
    export CFLAGS="-fPIC"
    export CXXFLAGS="-fPIC"
    ./configure --prefix="${INSTALL_DIR}" --with-shared --without-debug --without-ada --enable-widec --enable-pc-files --with-pkg-config-libdir="${INSTALL_DIR}/lib/pkgconfig"
    make -j "${NJOBS}"
    make install
    popd

    echoI "Installing zsh from source"
    ZSH_VERSION="5.9"
    wget -O "${TMP_DIR}/zsh-${ZSH_VERSION}.tar.xz" -nc "https://www.zsh.org/pub/zsh-${ZSH_VERSION}.tar.xz"
    tar xf "${TMP_DIR}/zsh-${ZSH_VERSION}.tar.xz" -C "${TMP_DIR}"
    pushd "${TMP_DIR}/zsh-${ZSH_VERSION}"
    export PKG_CONFIG_PATH="${INSTALL_DIR}/lib/pkgconfig"
    export CPPFLAGS="-I${INSTALL_DIR}/include"
    export LDFLAGS="-L${INSTALL_DIR}/lib"
    export CFLAGS="-I${INSTALL_DIR}/include"
    ./configure --prefix="${INSTALL_DIR}" --enable-shared
    make -j "${NJOBS}"
    make install
    popd

    unset CFLAGS CPPFLAGS LDFLAGS PKG_CONFIG_PATH
}

echoI "Install zsh"
if ! { type zsh >/dev/null 2>&1; }; then
    echoI "-- ZSH is not installed. Install zsh...."
    if $IS_SUDOER; then
        sudo apt install -y zsh
    else
        build_zsh_from_source
    fi
else
    echoI "-- zsh is already installed."
fi

# --------------------------------------------------
# set zsh as default shell
# --------------------------------------------------
if $IS_SUDOER; then
    ZSH_PATH=$(which zsh)
    echo "change default shell to zsh...."
    if ! grep -q "^${ZSH_PATH}$" /etc/shells; then
        sudo sh -c "echo ${ZSH_PATH} >> /etc/shells"
    fi
    chsh -s "${ZSH_PATH}"
else
    ZSH_BIN="${INSTALL_DIR}/bin/zsh"
    echo "change default shell to zsh...."
    if ! grep -q "^export SHELL=${ZSH_BIN}$" ~/.profile 2>/dev/null; then
        echo "export SHELL=${ZSH_BIN}" >>~/.profile
    fi
    if ! grep -q "^exec ${ZSH_BIN} -l$" ~/.profile 2>/dev/null; then
        echo "exec ${ZSH_BIN} -l" >>~/.profile
    fi
fi

# --------------------------------------------------
# create synbolic link of zshrc
# --------------------------------------------------
echoI "Create symbolic link of zshrc"
if [ ! -L ~/.zshrc ]; then
    ln -sf ${SCRIPT_DIR}/zshrc ~/.zshrc
    echoI "-- symbolic link of zshrc is created."
else
    echoI "-- symbolic link of zshrc is already created."
fi
