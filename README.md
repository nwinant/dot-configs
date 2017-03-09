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

    Cmd-[KEY]          : Window manager modifier (OSX)
    Cmd+Opt-[KEY]      : Window manager modifier (OSX)
    [F_KEY]            : Window manager function key modifier (i.e., no modifier)
    Opt-[KEY]          : Multiplexer modifier (GNU screen, tmux)
    Opt-\              : Multiplexer escape 
    Ctl-[KEY]          : Application modifier

```

Specific bindings:
```
Window manager:

    Win-Alt-[ARROW]    : Next/prev workspace
    Win-Alt-Esc        : Show all windows
    Win-Alt-`          : Show workspace windows
    Win-Alt-Tab        : Show application windows
    Win-Alt-[NUM]      : Switch to workspace [NUM]
    Win-Alt-Ctl-[NUM]  : Move window to workspace [NUM]

Application windows (Linux):

    Alt-Tab            : Cycle windows
    Alt-Shift-Tab      : Cycle windows (reverse)
    Ctl-Tab            : Cycle tabs within an application
    Ctl-PgDn           : "
    Ctl-Shift-Tab      : Cycle tabs within an application (reverse)
    Ctl-PgUp           : "

Application windows (OSX):

    Cmd-Tab            : Cycle windows
    Cmd-Shift-Tab      : Cycle windows (reverse)
    Cmd-`              : Cycle windows within an application
    Cmd-Shift-`        : Cycle windows within an application (reverse)
    Cmd-Opt-[ARROW]    : Cycle tabs within an application
    Ctl-Shift-Tab      : Cycle tabs within an application (reverse)

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
```


Directory structure
-------------------

Basics:

* `~/.bashrc.d` for configuration (and scripts specific to configuration)
* `~/bin` for third-party executables
* `~/scripts` for custom scripts
* Any bash files under `**/lib` are sourced, but not added to path.
* Any bash files immediately under `~/.bashrc` are sourced _after_ `**/lib`, but not added to path.
* All other directories are added to path.

Full directory structure, where `PLATFORM` is one of `osx, linux, freebsd`:

* `.bashrc.d/`
* `.bashrc.d/PLATFORM`
* `.bashrc.d/bin`
* `.bashrc.d/bin/PLATFORM`
* `.bashrc.d/lib`
* `.bashrc.d/lib/PLATFORM`
* `.bashrc.d/local`
* `.bashrc.d/local/bin`
* `.bashrc.d/local/lib`
* `bin`
* `scripts`
* `scripts/PLATFORM`
* `scripts/lib`
* `scripts/lib/PLATFORM`
* `scripts/local`
* `scripts/local/lib`

`bin` and `scripts` directories are assumed to be present, and are not created or symlinked.

Directories are sourced or added to `PATH` with the following precedence, if they exist:

1. local directories (e.g., `.bashrc.d/local`, `scripts/local`)
2. PLATFORM directories (e.g., `.bashrc.d/osx`, `scripts/osx`)
3. Default directories (e.g., `.bashrc.d`, `scripts`)

In other words, machine-specific (local) can override platform-specific, which can override default. By definition, local directories are ignored by this git repository.


Environment prep
-----------------

### OS X

Manually install the absolute basics:

1. Google chrome, because c'mon: https://www.google.com/chrome
2. XQuartz:   https://www.xquartz.org/
3. Homebrew:  http://brew.sh/
4. Meld:      https://yousseb.github.io/meld/

Install various essentials:

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


### Windows

1. Install babun: http://babun.github.io/
2. Suffer.


Installation
------------

    dotconfigs=~/.edc.d
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
    ln -s ${dotconfigs}/gitexcludes   ~/.gitexcludes
    ln -s ${dotconfigs}/screenrc      ~/.screenrc
    ln -s ${dotconfigs}/vimrc         ~/.vimrc


