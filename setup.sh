#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        sudo --reset-timestamp
        echo "This script must be run as root"
        if sudo true; then
                echo "Updating vimrc and tmux.conf"
        else
                echo "Aborting script"
                exit 1
        fi
fi

sudo apt-get update
sudo apt-get install git tmux vim-gtk -y

TMPDIR=$(mktemp -d)
VIMRC=$HOME/.vimrc
TMUX=$HOME/.tmux.conf
TMP_VIMRC=$TMPDIR/.vimrc
TMP_TMUX=$TMPDIR/.tmux.conf

git clone https://github.com/CrazyBonze/My-Vimrc "$TMPDIR"

if [ -f "$VIMRC" ]; then
        read -r -n 1 -p "${VIMRC} already exists, overwrite it? (y/n): " v_ans
        echo
        if [ "$v_ans" != "${v_ans#[Yy]}" ]; then
                echo "Overwriting ${VIMRC}"
                mv "$TMP_VIMRC" "$VIMRC"
        fi
else
        mv "$TMP_VIMRC" "$VIMRC"
fi

if [ -f "$TMUX" ]; then
        read -r -n 1 -p "${TMUX} already exists, overwrite it? (y/n): " t_ans
        echo
        if [ "$t_ans" != "${t_ans#[Yy]}" ]; then
                echo "Overwriting ${TMUX}"
                mv "$TMP_TMUX" "$TMUX"
        fi
else
        mv "$TMP_TMUX" "$TMUX"
fi

rm -rf "$TMPDIR"

