# lilvim

> a lil, modular config

## Features

- 🪴 Self-contained modules
- 📦 Prioritised built-in functionality
- 🥟 Deliciously simple to extend

## Usage

```sh
git clone https://github.com/mvllow/lilvim ~/.config/nvim
```

Alternatively, you may pull any module into your own config. At this time, `lua/lil-helpers.lua` is where shared module code lives, and is necessary in addition to your desired module(s).

## Modules

All modules are loaded in `init.lua`. If using a standalone module, please include `lua/lil-helpers.lua`.

_**[lil-ui](lua/lil-ui.lua)**_\
Interface elements such as colorscheme and statusline

_**[lil-editing](lua/lil-editing.lua)**_\
General options and keymaps

_**[lil-completions](lua/lil-completions.lua)**_\
Completions and snippets

_**[lil-lsp](lua/lil-lsp.lua)**_\
Language servers and diagnostics

_**[lil-search](lua/lil-search.lua)**_\
File and text search

_**[lil-extras](lua/lil-extras.lua)**_\
Not so lil enhancements

_**[lil-helpers](lua/lil-helpers.lua)**_\
Shared utility functions used by other modules

_For more snippets, head over to our [wiki](https://github.com/mvllow/lilvim/wiki)_

## Principles

> Heavily inspired by [Rational Emacs](https://github.com/SystemCrafters/rational-emacs)

### Minimal and modular by design

This project includes several self-contained modules which handle their own options, keymaps, and plugins. Any shared utilites can be found in `lil-helpers`.

### Prioritise built-in Neovim functionality

We have designed lilvim to demonstrate the capabilities of vanilla Neovim and lower the platform's barrier to entry for new users. Our approach encourages users to enjoy the benefits of a lightweight environment by first embracing the platform, then supplementing with plugins as needed.

## Related

There are plenty of projects that provide a framework of abstractions to simplify the learning curve of using Neovim over something like VSCode. Check out [LunarVim](https://github.com/LunarVim/LunarVim) or [AstroVim](https://github.com/kabinspace/AstroVim) if you want a great batteries-included Neovim configuration.

## Contributing

We welcome and appreciate contributions of any kind. Please open an issue to discuss the addition of new modules.
