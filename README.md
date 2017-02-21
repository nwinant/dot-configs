dot-configs
===========

Various configuration whatnot.


Basic principles
----------------

1. Vim uses standard vim key bindings. One of its strengths is its ubiquity, so no there's no cause to introduce non-standard muscle memory.
2. Emacs includes evil-mode. Again: muscle memory.
3. GNU screen uses standard key bindings for everything within a window (well, except for alt-\ as escape), but streamlined bindings for pretty much everything else.


Key bindings
------------

Applications:

    Ctl-F1     Term
    Ctl-F3     Emacs client

Audio:

    Win-F10    Mute
    Win-F11    Volume down
    Win-F12    Volume up

    (OSX: Just F10/F11/F12)


Environment prep
-----------------

### OS X

Manually install the absolute basics:

1. Google chrome, because c'mon: https://www.google.com/chrome
2. XQuartz:   https://www.xquartz.org/
3. Homebrew:  http://brew.sh/
4. Oh My Zsh: http://ohmyz.sh/

Install various essentials:

    brew install rxvt-unicode
    brew install emacs --cocoa
    #brew install Caskroom/cask/xquartz
    #brew install homebrew/x11/meld

Set XQuartz to do default to urxvt:

    defaults write org.macosforge.xquartz.X11 app_to_run $(which urxvt)

Various tweaks via the UI:

1. Add urxvt to XQuartz Applications menu, mapped to command-M
2. Set function keys to behave like... functions keys: https://support.apple.com/en-us/HT204436 
3. Map Caps Lock to Ctrl: System Preferences > Keyboard > Modifier Key


### Windows

1. Install babun: http://babun.github.io/
2. Suffer.


Installation
------------

    dotconfigs=~/.${USER}.d
    git clone https://github.com/nwinant/dot-configs.git ${dotconfigs}

    # Dirs
    ln -s ${dotconfigs}/Xresources.d  ~/.Xresources.d
    ln -s ${dotconfigs}/bashrc.d      ~/.bashrc.d
    ln -s ${dotconfigs}/emacs.d       ~/.emacs.d
    ln -s ${dotconfigs}/vim           ~/.vim

    # Files
    ln -s ${dotconfigs}/inputrc       ~/.inputrc
    ln -s ${dotconfigs}/Xresources    ~/.Xresources
    ln -s ${dotconfigs}/bashrc        ~/.bashrc
    ln -s ${dotconfigs}/gitconfig     ~/.gitconfig
    ln -s ${dotconfigs}/screenrc      ~/.screenrc
    ln -s ${dotconfigs}/vimrc         ~/.vimrc


