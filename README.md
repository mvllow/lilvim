# lilvim

> A modular and opinionated starting point for Neovim

## Features

- 🪴 Self-contained modules
- 📦 Documented built-in functionality
- 🥟 Deliciously simple to extend

## Usage

```sh
# Notice the destination folder is lilvim, not nvim
git clone https://github.com/mvllow/lilvim ~/.config/lilvim

# Run lilvim by setting the NVIM_APPNAME environment variable
NVIM_APPNAME=lilvim nvim
```

Alternatively, install as a plugin for automatic loading:

```lua
vim.pack.add({
	"https://github.com/mvllow/lilvim"
})
```

Or copy individual modules from `plugin/` into your own config's `plugin/` directory.

## Modules

> If installed as a plugin, you may run `:help lilvim` for the complete documentation.

_**[lil-complete](plugin/lil-complete.lua)**_\
Text (auto)completion

_**[lil-edit](plugin/lil-edit.lua)**_\
General editing keymaps and options

_**[lil-lsp](plugin/lil-lsp.lua)**_\
Language servers and diagnostics

_**[lil-places](plugin/lil-places.lua)**_\
Extend built-in mark behaviour

_**[lil-quickfix](plugin/lil-quickfix.lua)**_\
Extend built-in quickfix behaviour

_**[lil-search](plugin/lil-search.lua)**_\
File management and search

_**[lil-stats](plugin/lil-stats.lua)**_\
Show file statistics

_**[lil-subs](plugin/lil-subs.lua)**_\
Substitute your text, with different text

_For not-so-lil module extensions, head over to our [wiki](https://github.com/mvllow/lilvim/wiki)_

## Principles

> Heavily inspired by [Rational Emacs](https://github.com/SystemCrafters/rational-emacs)

### Minimal and modular by design

Lilvim includes several self-contained modules which handle their own vim options, keymaps and configurations. This approach differs from the common practice of separating functionality by plugin.

### Prioritise built-in Neovim functionality

We demonstrate Neovim's built-in capabilities and lower the platform's barrier to entry for new users. This lightweight approach encourages users to first understand the platform's features before adding plugins.

### Idiomatic loading

Neovim's `plugin` directory automatically loads all modules on startup. Each module is self-contained and can be copied individually.

## Related

If you're looking for a more robust starting point for your own config, check out [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It provides an excellent foundation with detailed explanations of each component.

For users seeking a batteries-included experience, consider:

- [LazyVim](https://github.com/LazyVim/LazyVim) - Modern and feature-rich config
- [AstroVim](https://github.com/kabinspace/AstroVim) - Beautiful and customisable environment

## Contributing

We welcome and appreciate contributions of any kind. Please open an issue to discuss the addition of new modules.
