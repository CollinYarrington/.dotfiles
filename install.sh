#!/usr/bin/env bash

# Install "zsh" if its not already installed
if [[ ! $(command -v zsh) ]]; then
    apt install zsh
fi

# Install "oh-my-zsh" if its not already installed
if [[ ! d ~/.oh-my-zsh/plugins ]]; then
    # See the docs for more info here: https://ohmyz.sh/#install
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

set -e

CONFIG="install.conf.yaml"
DOTBOT_DIR="dotbot"

DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
