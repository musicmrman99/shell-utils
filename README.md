# Utils
My utility aliases and functions (for BASH).

# Installation
## Under `bashctl`
To use it under [`bashctl`](https://github.com/musicmrman99/bashctl "bashctl on GitHub") (recommended if you use `bashctl`):
```sh
# Or whatever component you want to install it to
git clone https://github.com/musicmrman99/shell-utils.git "$BASH_LIB_COMPONENT_ROOT"/utils
bashctl --update-symlinks
```
... then add the following to your `.bashrc`:
```sh
src 'utils:.*'
```

## Without `bashctl`
Clone the repo somewhere:
```sh
git clone https://github.com/musicmrman99/utils.git "[INSTALL LOCATION]"
```

Then add the following to your (Bourne-compatible) shell's init file:
```sh
if [ -f "[INSTALL LOCATION]" ]; then
    . [INSTALL LOCATION]/*.def.sh
fi
```
