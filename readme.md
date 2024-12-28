# lilvim

> a lil, modular config

## Features

- 🪴 Self-contained modules
- 📦 Prioritised built-in functionality
- 🥟 Deliciously simple to extend

## Usage

```sh
# Notice the destination folder is lilvim, not nvim
git clone https://github.com/mvllow/lilvim ~/.config/lilvim

# Run lilvim by setting the NVIM_APPNAME environment variable
NVIM_APPNAME=lilvim nvim
```

Alternatively, you may pull any module into your own config. Individual modules rely on [mini.deps](https://github.com/echasnovski/mini.deps) for managing packages. You may opt for your own package manager or manually cloning the required dependencies. See `:help packages` for more information on the builtin package manager.

## Modules

All modules are loaded in `init.lua`. If using a standalone module, please handle installing the necessary dependencies. For the best support, we recommended installing [mini.deps](https://github.com/echasnovski/mini.deps?tab=readme-ov-file#installation).

_**[lil-editing](lua/lil-editing.lua)**_\
General options and keymaps

_**[lil-lsp](lua/lil-lsp.lua)**_\
Language servers and diagnostics

_**[lil-search](lua/lil-search.lua)**_\
File discovery and text navigation

_**[lil-ui](lua/lil-ui.lua)**_\
Treesitter and interface options

_For not-so-lil module extensions, head over to our [wiki](https://github.com/mvllow/lilvim/wiki)_

## Principles

> Heavily inspired by [Rational Emacs](https://github.com/SystemCrafters/rational-emacs)

### Minimal and modular by design

This project includes several self-contained modules which handle their own options, keymaps, and plugins, contrary to another popular approach of isolating those three categories.

### Prioritise built-in Neovim functionality

We have designed lilvim to demonstrate the capabilities of vanilla Neovim and lower the platform's barrier to entry for new users. Our approach encourages users to enjoy the benefits of a lightweight environment by first embracing the platform, then supplementing with plugins as needed.

### Statistics

```
$ tokei ./lilvim/**/*.lua
===============================================================================
 Language            Files        Lines         Code     Comments       Blanks
===============================================================================
 Lua                     6          264          111          128           25
===============================================================================
 Total                   6          264          111          128           25
===============================================================================
```

## Related

There are plenty of projects that provide a framework of abstractions to simplify the learning curve of using Neovim over something like VSCode. Check out [LunarVim](https://github.com/LunarVim/LunarVim) or [AstroVim](https://github.com/kabinspace/AstroVim) if you want a great batteries-included Neovim configuration.

## Contributing

We welcome and appreciate contributions of any kind. Please open an issue to discuss the addition of new modules.
