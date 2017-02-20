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

````
dotconfigs=~/.${USERNAME}.d
git clone https://github.com/nwinant/dot-configs.git ${dotconfigs}

# Dirs
ln -s ${dotconfigs}/Xresources.d ~/.Xresources.d

# Files
ln -s ${dotconfigs}/Xresources ~/.Xresources

````


