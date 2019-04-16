dot-configs
===========

Various configuration whatnot.


Basic principles
================

1. Vim uses standard vim key bindings. One of its strengths is its ubiquity, so no there's no cause to introduce non-standard muscle memory.
2. Emacs includes evil-mode. Again: muscle memory.
3. GNU screen uses standard key bindings for everything within a window (well, except for alt-\ as escape), but streamlined bindings for pretty much everything else.


Key bindings
============

General rules for custom bindings:
```
Linux/X11:

    Win-[KEY]          : Window manager modifier
    Win+Alt-[KEY]      : Window manager modifier
    Win-[F_KEY]        : Window manager function key modifier
    Alt-[KEY]          : Multiplexer modifier (GNU screen, tmux)
    Alt-\              : Multiplexer escape 
    Ctl-[KEY]          : Application modifier

OSX:

    Cmd-[KEY]          : Window manager modifier
    Cmd+Opt-[KEY]      : Window manager modifier
    [F_KEY]            : Window manager function key modifier (i.e., no modifier)
    Opt-[KEY]          : Multiplexer modifier (GNU screen, tmux)
    Opt-\              : Multiplexer escape 
    Ctl-[KEY]          : Application modifier

```

Specific bindings:
```
Window manager:

    Win-[ARROW]        : Next/prev workspace
    Win-Esc            : Show all windows
    Win-Esc            : Show workspace windows
    Win-`              : Show application windows
    Win-[NUM]          : Switch to workspace [NUM]
    Win-Alt-[NUM]      : Move window to workspace [NUM]

Multiplexer (GNU screen):

    Alt-[ARROW]        : Cycle windows

Application windows (Linux):

    Alt-Tab            : Cycle windows in workspace
    Alt-Shift-Tab      : Cycle windows in workspace (reverse)
    Ctl-Tab            : Cycle tabs in application window            (also:  Ctl-PgDn)
    Ctl-Shift-Tab      : Cycle tabs in application window (reverse)  (also:  Ctl-PgUp)

Application windows (OSX):

    NOTE: OSX offer workspace window cycling (Prefs > Keyboard > Shortcuts > Move focus to active 
          or next windows) but in practice this can be flaky.

    Cmd-Tab            : Cycle applications globally
    Cmd-Shift-Tab      : Cycle applications globally (reverse)
    Cmd-Opt-Tab        : Cycle windows in workspace
    Cmd-Opt-Shift-Tab  : Cycle windows in workspace (reverse)
    Opt-Tab            : Cycle windows in application
    Opt-Shift-Tab      : Cycle windows in application (reverse)
    Ctl-Tab            : Cycle tabs in application window
    Ctl-Shift-Tab      : Cycle tabs in application window (reverse)
    Cmd-=/-            : Increase/decrease text size

Application launchers:

    Win-F1             : Term
    Win-F2             : Notepad/gedit/etc.
    Win-F3             : Emacs client
    Win-F4             : - none -
    Win-F5             : Browser, primary profile
    Win-F6             : Browser, secondary profile
    Win-SPACE          : Application launcher (quicksilver, etc.)

Audio:

    Win-F9             : Pause/Resume
    Win-F10            : Mute
    Win-F11            : Volume down
    Win-F12            : Volume up
    
   (OSX: Just F10/F11/F12)
````
General application shortcuts:
````
    Ctl-Space          : Autocomplete word
````
Specific applications:
````
Emacs:

    C-x C-=/-          : Increase/decrease text size
````


Directory structure
===================

Basics:

* `aliases` contains scripts which wrap calls to other scripts & executables.
* `bin` contains third-party executables. 
   This is always a local directory, is assumed to be present, and is not created.
* `scripts` contains custom scripts.
* `$PLATFORM` directories contain platform-specific files, 
   where `$PLATFORM` is one of `osx, linux, freebsd`.
* `local` directories are machine/installation-specific. 
   By definition, they are ignored by this git repository.
* `lib` directories contain files which may be sourced by other scripts,
   but are not sourced by default.

Order of precedence: 

* Aliases override scripts which override third-party files (bin), _except..._
* Local/machine-specific files override platform-specific files.
* Platform-specific files override default files.

Full directory structure:
 
    .edc.d/Xresources
          /aliases
          /bashrc.d
                   /$PLATFORM
                   /local
          /emacs.d
                  /local
          /local
          /osx
          /scripts
                  /$PLATFORM
                  /lib
                      /$PLATFORM
                  /local
                        /lib
          /vim/
    .Xresources.d@
    .bashrc.d@
    .emacs.d@
    .vim@
    aliases@
    bin
    scripts@

Directories which are sourced (highest precedence first):

* `bashrc.d/local`
* `bashrc.d/$PLATFORM`
* `bashrc.d`

Directories which are added to PATH (highest precedence first):

* `aliases/local`
* `scripts/local`
* `bin`
* `aliases/$PLATFORM`
* `scripts/$PLATFORM`
* `aliases`
* `scripts`

File naming conventions:

* Scripts only have a suffix if their implementation matters (e.g., `ansi-codes.sh` contains 
  variables to be sourced by bash scripts). This makes for cleaner names (IMO) and reduces the
  likelihood that other code will need to be rewritten if/when a script is rewritten.
* The `.sh` suffix is used interchangeably with `.bash` because life is too short for 
  hand-wringing over that.


Environment prep
================

OS X
----

Manually install the absolute basics:

1. Google chrome, because c'mon: https://www.google.com/chrome
2. XQuartz:      https://www.xquartz.org/
3. Homebrew:     http://brew.sh/
4. Meld:         https://yousseb.github.io/meld/
5. Quicksilver:  https://qsapp.com/download.php

Install various essentials:

    brew update
    brew install bash                   ##|  Update to bash 4
    brew install rxvt-unicode
    brew install emacs --cocoa
    brew install markdown
    brew install git bash-completion

Set XQuartz to do default to urxvt:
 
    defaults write org.macosforge.xquartz.X11 app_to_run $(which urxvt)

Various tweaks via the UI:

1. Add urxvt to XQuartz Applications menu, mapped to command-M
2. Set function keys to behave like... functions keys: https://support.apple.com/en-us/HT204436 
3. Map Caps Lock to Ctrl: System Preferences > Keyboard > Modifier Key

### iTerm2

iTerm2 is just rad: <https://iterm2.com/downloads.html>

Fix the keybindings so that `OPT-ARROW` will skip words & emacs will behave sanely:

1. Go to `Preferences...` > `Profiles` > `Keys`
2. Press `Load Preset...`
3. Select `Natural Text Editing`

See:

* <https://apple.stackexchange.com/questions/154292/iterm-going-one-word-backwards-and-forwards>


Windows
-------

Windows installation is refreshingly simple:

1. Install babun: http://babun.github.io/
2. Suffer.

***Update:*** [Suffer even more](https://github.com/babun/babun/issues/868).

### Windows Subsystem for Linux (WSL)

I must grudgingly admit that WSL does make things a fair bit better on Win 10.

See:

* https://docs.microsoft.com/en-us/windows/wsl/install-win10

### Cmder

Not too shabby: https://cmder.net/


Installation
============

    dotconfigs=~/.edc.d
    git clone https://github.com/nwinant/dot-configs.git ${dotconfigs}

    ##|  Dirs
    ln -s ${dotconfigs}/bashrc.d      ~/.bashrc.d
    ln -s ${dotconfigs}/emacs.d       ~/.emacs.d
    ln -s ${dotconfigs}/vim           ~/.vim
    ln -s ${dotconfigs}/Xresources.d  ~/.Xresources.d

    ##|  Files
    ln -s ${dotconfigs}/bashrc        ~/.bashrc
    ln -s ${dotconfigs}/gitconfig     ~/.gitconfig
    ln -s ${dotconfigs}/gitexcludes   ~/.gitexcludes
    ln -s ${dotconfigs}/inputrc       ~/.inputrc
    ln -s ${dotconfigs}/screenrc      ~/.screenrc
    ln -s ${dotconfigs}/vimrc         ~/.vimrc
    ln -s ${dotconfigs}/Xresources    ~/.Xresources
    ln -s ${dotconfigs}/xsessionrc    ~/.xsessionrc


