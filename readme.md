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
General editing configurations with sensible defaults

_**[lil-grep](lua/lil-grep.lua)**_\
Enhanced grep functionality

_**[lil-lsp](lua/lil-lsp.lua)**_\
Language server and diagnostics setup

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

Lilvim includes several self-contained modules which handle their own vim options, keymaps and configurations. This approach differs from the common practice of separating functionality by plugin.

### Prioritise built-in Neovim functionality

We demonstrate Neovim's built-in capabilities and lower the platform's barrier to entry for new users. This lightweight approach encourages users to first understand the platform's features before adding plugins.

## Related

If you're looking for a more robust starting point for your own config, check out [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It provides an excellent foundation with detailed explanations of each component.

For users seeking a batteries-included experience, consider:
- [LazyVim](https://github.com/LazyVim/LazyVim) - Modern and feature-rich config
- [AstroVim](https://github.com/kabinspace/AstroVim) - Beautiful and customisable environment

## Contributing

We welcome and appreciate contributions of any kind. Please open an issue to discuss the addition of new modules.
