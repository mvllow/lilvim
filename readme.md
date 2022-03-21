# lilvim

> a lil, modular config

## Features

- 🪴 Self-contained modules
- 📦 Prioritised builtin functionality
- 🥟 Deliciously simple to extend

## Usage

```sh
git clone https://github.com/mvllow/lilvim ~/.config/nvim
```

Alternatively, you may pull any module into your own config. At this time, `lua/lil-helpers.lua` is where shared module code lives, and is necessary in addition to your desired module(s).

## Modules

All modules are loaded in `init.lua`. If using a standalone module, please include `lua/lil-helpers.lua`.

**lil-ui**\
Interface elements such as colorscheme and statusline

**lil-editing**\
General options and keymaps

**lil-completions**\
Completions and snippets

**lil-lsp**\
Language servers and diagnostics

**lil-search**\
File and text search

**lil-helpers**\
Shared utility functions used by other modules

## Principles

> Heavily inspired by [Rational Emacs](https://github.com/SystemCrafters/rational-emacs)

### Minimal and modular by design

This project includes several self-contained modules which handle their own options, keymaps, and plugins. Any shared utilites can be found in `lil-helpers`.

### Prioritise built-in Neovim functionality

We have designed lilvim to demonstrate the capabilities of vanilla Neovim and lower the platform's barrier to entry for new users. Our approach encourages users to enjoy the benefits of a lightweight environment by first embracing the platform, then supplementing with plugins as needed.

## Related

There are plenty of projects that provide a framework of abstractions to simplify the learning curve of using Neovim over something like VSCode. Check out [LunarVim](https://github.com/LunarVim/LunarVim) or [AstroVim](https://github.com/kabinspace/AstroVim) if you want a great batteries-included Neovim configuration.

## Contributing

We welcome and appreciate all contributions, especially ones that involve removing plugins 😉
