#!/bin/bash

echo "--------------------------------------------"
echo "| Setting up for Jonathan Merritt's EMACS! |"
echo "--------------------------------------------"

if [ -d "~/.emacs.d/vendor" ]; then
    echo "Creating vendor directory ~/.emacs.d/vendor"
    mkdir -p ~/.emacs.d/vendor
fi

echo "Updating / installing milkypostman/powerline (cute status bar / modeline)"
cd ~/.emacs.d/vendor
if [ -d "powerline" ]; then
    echo "--> already installed; updating via git"
    cd powerline
    git pull
else
    echo "--> not installed; performing a git clone"
    git clone https://github.com/milkypostman/powerline.git
fi

echo "Ensime (scala mode for emacs)"
cd ~/.emacs.d/vendor
if [ ! -d "ensime_2.10.0-0.9.8.9" ]; then
    echo "--> not installed, doing a wget and extraction"
    wget https://www.dropbox.com/sh/ryd981hq08swyqr/ZiCwjjr_vm/ENSIME%20Releases/ensime_2.10.0-0.9.8.9.tar.gz
    tar xzf ensime_2.10.0-0.9.8.9.tar.gz
    rm ensime_2.10.0-0.9.8.9.tar.gz
else
    echo "--> already installed"
fi

echo "Julia mode"
cd ~/.emacs.d/vendor
if [ ! -e "julia-mode.el" ]; then
    echo "--> not installed, doing a wget"
    wget https://raw.github.com/JuliaLang/julia/master/contrib/julia-mode.el
else
    echo "--> already installed"
fi
