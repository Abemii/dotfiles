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

# --------------------------------------------------
# install uv
# --------------------------------------------------
echoI "install uv"
if ! { type uv >/dev/null 2>&1; }; then
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # check if uv is installed
    if { type uv >/dev/null 2>&1; }; then
        echoI "-- uv is installed."
        uv --version
    else
        echoE "-- uv is not installed."
        exit 1
    fi
else
    echoI "-- uv is already installed."
fi

# --------------------------------------------------
# create nvim python host program
# --------------------------------------------------
echoI "Create nvim python host program"
# install to ${SCRIPT_DIR}/.venv-nvim
if [ ! -d "${SCRIPT_DIR}/.venv" ]; then
    uv sync
    for bin in ruff isort trash-put; do
        ln -sf "${SCRIPT_DIR}/.venv/bin/${bin}" "${INSTALL_DIR}/bin/${bin}"
    done
    export PYTHON3_HOST_PROG="${SCRIPT_DIR}/.venv/bin/python"
    echoI "-- nvim python host program is created."
else
    echoI "-- nvim python host program is already created."
fi

# --------------------------------------------------
# install node and npm
# --------------------------------------------------
IS_NVM_DIR_INSTALLED=0
NVM_DIR_CANDIDATES=(
    "${HOME}/.nvm"
    "${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
)
for CANDIDATE in "${NVM_DIR_CANDIDATES[@]}"; do
    if [ -s "${CANDIDATE}/nvm.sh" ]; then
        export NVM_DIR="${CANDIDATE}"
        IS_NVM_DIR_INSTALLED=1
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
        break
    fi
done

if [ $IS_NVM_DIR_INSTALLED -eq 0 ]; then
    echoI "NVM is not installed. Installing NVM..."

    unset NVM_DIR
    NVM_VERSION="v0.40.1"
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash

    if [ -z "${XDG_CONFIG_HOME}" ]; then
        export NVM_DIR="${HOME}/.nvm"
    else
        export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
    fi
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

    # check if nvm is installed
    if { type nvm >/dev/null 2>&1; }; then
        echoI "-- nvm is installed."
        nvm -v # v0.40.1
    else
        echoE "-- nvm is not installed."
        exit 1
    fi
else
    echoI "NVM is already installed."
fi

# check if node and nvm is installed
echoI "Install node and npm"
if ! { type node >/dev/null 2>&1 || type npm >/dev/null 2>&1; }; then
    nvm install --lts --latest-npm

    # check if node is installed
    if { type node >/dev/null 2>&1; }; then
        echoI "-- node is installed."
        node -v # v22.13.0
    else
        echoE "-- node is not installed."
        exit 1
    fi

    # check if npm is installed
    if { type npm >/dev/null 2>&1; }; then
        echoI "-- npm is installed."
        npm -v # 10.9.2
    else
        echoE "-- npm is not installed."
        exit 1
    fi
else
    echoI "-- node and npm are already installed."
fi

# --------------------------------------------------
# install deno
# --------------------------------------------------
echoI "Install deno"
export PATH="${HOME}/.deno/bin:$PATH"
if ! { type deno >/dev/null 2>&1; }; then
    curl -fsSL https://deno.land/install.sh | sh

    # check if deno is installed
    if { type deno >/dev/null 2>&1; }; then
        echoI "-- deno is installed."
    else
        echoE "-- deno is not installed."
        exit 1
    fi
else
    echoI "-- deno is already installed."
fi

# --------------------------------------------------
# install ripgrep (for telescope)
# --------------------------------------------------
echoI "Install ripgrep (rg)"
if ! { type rg >/dev/null 2>&1; }; then
    RG_VERSION="14.1.1"
    wget https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz -P ${TMP_DIR}
    tar zxf ${TMP_DIR}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz -C ${INSTALL_DIR}
    ln -s ${INSTALL_DIR}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg ${INSTALL_DIR}/bin/rg

    # check if rg is installed
    if { type rg >/dev/null 2>&1; }; then
        echoI "-- rg is installed."
    else
        echoE "-- rg is not installed."
        exit 1
    fi
else
    echoI "-- rg is already installed."
fi

# --------------------------------------------------
# install clang-format
# --------------------------------------------------
echoI "Install clang-format"
if ! { type clang-format >/dev/null 2>&1; }; then
    CLANG_FORMAT_VERSION="17.0.6"
    LLVM_BASENAME="clang+llvm-${CLANG_FORMAT_VERSION}-x86_64-linux-gnu-ubuntu-22.04"
    LLVM_ARCHIVE="${LLVM_BASENAME}.tar.xz"
    LLVM_URL="https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANG_FORMAT_VERSION}/${LLVM_ARCHIVE}"
    wget "${LLVM_URL}" -P "${TMP_DIR}"
    tar -xf "${TMP_DIR}/${LLVM_ARCHIVE}" -C "${INSTALL_DIR}"
    ln -s "${INSTALL_DIR}/${LLVM_BASENAME}/bin/clang-format" "${INSTALL_DIR}/bin/clang-format"

    if { type clang-format >/dev/null 2>&1; }; then
        echoI "-- clang-format is installed."
        clang-format --version
    else
        echoE "-- clang-format is not installed."
        exit 1
    fi
else
    echoI "-- clang-format is already installed."
fi

# --------------------------------------------------
# install shfmt
# --------------------------------------------------
echoI "Install shfmt"
if ! { type shfmt >/dev/null 2>&1; }; then
    SHFMT_VERSION="v3.6.0"

    wget https://github.com/mvdan/sh/releases/download/${SHFMT_VERSION}/shfmt_${SHFMT_VERSION}_linux_amd64 -O "$INSTALL_DIR/bin/shfmt"
    chmod +x "$INSTALL_DIR/bin/shfmt"

    # check if shfmt is installed
    if { type shfmt >/dev/null 2>&1; }; then
        echoI "-- shfmt is installed."
        shfmt --version
    else
        echoE "-- shfmt is not installed."
        exit 1
    fi
else
    echoI "-- shfmt is already installed."
fi

# --------------------------------------------------
# install stylua
# --------------------------------------------------
echoI "Install stylua"
if ! { type stylua >/dev/null 2>&1; }; then
    STYLUA_VERSION="v2.0.2"
    wget https://github.com/JohnnyMorganz/StyLua/releases/download/${STYLUA_VERSION}/stylua-linux-x86_64.zip -P ${TMP_DIR}
    unzip ${TMP_DIR}/stylua-linux-x86_64.zip -d "${INSTALL_DIR}/bin"
    chmod +x "${INSTALL_DIR}/bin/stylua"

    # check if stylua is installed
    if { type stylua >/dev/null 2>&1; }; then
        echoI "-- stylua is installed."
        stylua --version
    else
        echoE "-- stylua is not installed."
        exit 1
    fi
else
    echoI "-- stylua is already installed."
fi

# --------------------------------------------------
# install jq
# --------------------------------------------------
echoI "Install jq"
if ! { type jq >/dev/null 2>&1; }; then
    JQ_VERSION="jq-1.7.1"
    wget https://github.com/stedolan/jq/releases/download/${JQ_VERSION}/jq-linux64 -O "${INSTALL_DIR}/bin/jq"
    chmod +x "$INSTALL_DIR/bin/jq"

    # check if jq is installed
    if { type jq >/dev/null 2>&1; }; then
        echoI "-- jq is installed."
        jq --version
    else
        echoE "-- jq is not installed."
        exit 1
    fi
else
    echoI "-- jq is already installed."
fi

# --------------------------------------------------
# install nvim
# --------------------------------------------------
echoI "Install nvim"
if ! { type nvim >/dev/null 2>&1; }; then
    NVIM_VERSION="0.10.3"
    wget -P ${TMP_DIR} https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz
    tar zxf ${TMP_DIR}/nvim-linux64.tar.gz -C ${INSTALL_DIR}
    ln -s ${INSTALL_DIR}/nvim-linux64/bin/nvim ${INSTALL_DIR}/bin/nvim

    # check if nvim is installed
    if { type nvim >/dev/null 2>&1; }; then
        echoI "-- nvim is installed."
    else
        echoE "-- nvim is not installed."
        exit 1
    fi
else
    echoI "-- nvim is already installed."
fi

# --------------------------------------------------
# FINISH
# --------------------------------------------------
echoI "Complete!"
echoI "Please run the following command."
echo ""
echo "export PATH=\"${INSTALL_DIR}/bin:\$PATH\""
echo "export PATH=\"${HOME}/.deno/bin:\$PATH\""
echo "export LD_LIBRARY_PATH=\"${INSTALL_DIR}/lib/x86_64-linux-gnu:\$LD_LIBRARY_PATH\""
echo "source ${HOME}/.nvm/nvm.sh"
echo ""
echoI "Run 'nvim'"
