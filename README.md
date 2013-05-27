.emacs
======

Jonathan Merritt's .emacs file.

I use emacs across several computers, so I was motivated to store my emacs setup in GitHub to make it easier for me to
grab it when I have to set up on a new machine.

This repository has two main files:
  - dotemacs.el, which is the .emacs file, and
  - emacs-setup.sh, which is a shell script that grabs all of the dependencies of emacs that I use.

To set up, the basic instructions are as follows:
  1. Clone the repository somewhere: `cd <DIR> && git clone git://github.com/lancelet/dotemacs.git`
  2. Symlink the dotemacs.el file: `ln -s <DIR>/dotemacs/dotemacs.el ~/.emacs`
  3. READ the emacs-setup.sh file and then execute it: `bash emacs-setup.sh`
