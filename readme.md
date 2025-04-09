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

Alternatively, you may pull any module into your own config.

## Modules

All modules are loaded in `init.lua`.

_**[lil-editing](lua/lil-editing.lua)**_\
General options and keymaps

_**[lil-grep](lua/lil-grep.lua)**_\
Enhanced grep functionality

_**[lil-lsp](lua/lil-lsp.lua)**_\
Language servers and diagnostics

_**[lil-places](lua/lil-places.lua)**_\
Enhanced mark management with session-scoped persistence

_**[lil-quickfix](lua/lil-quickfix.lua)**_\
Enhanced quickfix window and entry management

_**[lil-search](lua/lil-search.lua)**_\
File management and search utilities

_For not-so-lil module extensions, head over to our [wiki](https://github.com/mvllow/lilvim/wiki)_

## Principles

> Heavily inspired by [Rational Emacs](https://github.com/SystemCrafters/rational-emacs)

### Minimal and modular by design

This project includes several self-contained modules which handle their own vim options, keymaps and configurations, contrary to another popular approach of isolating those three categories.

### Prioritise built-in Neovim functionality

We have designed lilvim to demonstrate the capabilities of vanilla Neovim and lower the platform's barrier to entry for new users. Our approach encourages users to enjoy the benefits of a lightweight environment by first embracing the platform, then supplementing with plugins as needed.

## Related

[NativeVim](https://github.com/boltlessengineer/NativeVim) provides several features and has great documentation. This is a great place to look for inspiration without sacrificing features.

There are plenty of projects that provide a framework of abstractions to simplify the learning curve of using Neovim over something like Sublime Text or Visual Studio Code. Check out [LazyVim](https://github.com/LazyVim/LazyVim) or [AstroVim](https://github.com/kabinspace/AstroVim) if you want a great batteries-included Neovim configuration or [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)—a more robust and feature-rich starting point for your own config.

## Contributing

We welcome and appreciate contributions of any kind. Please open an issue to discuss the addition of new modules.
