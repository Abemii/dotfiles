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

# install software
echoI "Install software"

# ---------------------------------------------------
# install wezterm for osc52
# ---------------------------------------------------
if ! { type wezterm >/dev/null 2>&1; }; then
    echoI "Install wezterm"
    if $IS_SUDOER; then
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
        sudo apt update
        sudo apt install -y wezterm
    else
        : >/dev/null
        echoE "Not sudoer, please install wezterm manually."
        # WEZTERM_VERSION="20240203-110809-5046fc22"
        # wget https://github.com/wezterm/wezterm/releases/download/${WEZTERM_VERSION}/wezterm-${WEZTERM_VERSION}.Ubuntu20.04.tar.xz -P ${TMP_DIR}
    fi
else
    echoI "-- wezterm is already installed."
fi

# ---------------------------------------------------
# install hackgen
# ---------------------------------------------------
echoI "Install hackgen"
if ! { type fc-list >/dev/null 2>&1; }; then
    echoE "-- fc-list is not installed. skip installing hackgen."
elif ! { fc-list | grep HackGen >/dev/null 2>&1; }; then
    HACKGEN_VERSION="2.10.0"
    FONT_INSTALL_DIR="${HOME}/.local/share/fonts"
    wget -P ${TMP_DIR} https://github.com/yuru7/HackGen/releases/download/v${HACKGEN_VERSION}/HackGen_NF_v${HACKGEN_VERSION}.zip
    unzip ${TMP_DIR}/HackGen_NF_v${HACKGEN_VERSION}.zip -d ${TMP_DIR}
    if [ ! -d ${FONT_INSTALL_DIR} ]; then
        mkdir -p ${FONT_INSTALL_DIR}
    fi
    cp -r ${TMP_DIR}/HackGen_NF_v${HACKGEN_VERSION} ${FONT_INSTALL_DIR}/HackGen_NF

    fc-cache -fv

    # check if HackGen is installed
    if { fc-list | grep HackGen >/dev/null 2>&1; }; then
        echoI "-- HackGen is installed."
    else
        echoE "-- HackGen is not installed."
        exit 1
    fi
else
    echoI "-- HackGen is already installed."
fi

# install essential packages
# if $IS_DEBIAN && $IS_SUDOER; then
#     sudo apt-get update
#     sudo apt-get install -y wget build-essential unzip
# fi

# install neovim related
# ${SCRIPT_DIR}/setup_nvim.sh
