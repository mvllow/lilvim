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

**lil-ui**

Interface elements such as colorscheme and statusline

**lil-editing**

General options and keymaps

**lil-completions**

Completions and snippets

**lil-lsp**

Language servers and diagnostics

**lil-search**

File and text search

**lil-helpers**

Shared utility functions used by other modules

## Principles

> Heavily inspired by [Rational Emacs](https://github.com/SystemCrafters/rational-emacs)

### Minimal and modular by design

Modules should be self-contained; Changing options, setting up keymaps, and installing plugins are all handled on a per-module basis. Any shared utilites can be found in `lil-helpers.lua`.

### Prioritise built-in Neovim functionality

While Neovim does not come with as much out of the box compared to Emacs, we try to push this idea to the limits. There are currently more plugins than necessary – and those may disappear once we have comparable, competing solutions.

## Related

There are plenty of projects that provide a framework of abstractions to simplify the learning curve of using Neovim over something like VSCode. I would encourage checking out [LunarVim](https://github.com/LunarVim/LunarVim) if you want a great batteries-included Neovim configuration.

## Contributing

We welcome and encourage all contributions; Especially if it includes removing plugins 😉
