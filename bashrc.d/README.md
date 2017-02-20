Contains run command (rc) files to be sourced via ~/.bashrc. All `*.sh` & `*.bash` files in this immediate directory will be sourced.

Subdirectories:

* `lib/` - Assumed functionality. All `*.sh` & `*.bash` files in lib will be sourced before any 
   other files. It is assumed that no file in lib should have a dependency upon any other file in lib.
* `bin/` - Scripts which are not sourced directly, but may be referenced by rc files; e.g., may be 
   mapped to an alias.

