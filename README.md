# lilvim

> A modular and opinionated starting point for Neovim

## Features

- 🪴 Self-contained modules
- 📦 Documented built-in functionality
- 🥟 Deliciously simple to extend

## Setup

Welcome to lilvim and possibly even Neovim!

To get started, copy the modules you like into your config, usually at
`~/.config/nvim/lua/`. Feel free to copy them all — only the ones you
enable will be active. If you're new to Neovim, you'll also want to create your
entrypoint at `~/.config/nvim/init.lua`.

The help documentation is your friend, whether you are new or seasoned. To
learn more about configuring Neovim, press `esc` and type `:help config`, then
press enter. That's your first command!

Now, in your `init.lua`, require the modules you want active:

```lua
require("lil-edit")
require("lil-lsp")
-- etc.
```

## Documentation

Lilvim ships with documentation on useful commands, keymaps and other goodies
for each module. You may [read it online](doc/lilvim.txt), although we
recommend copying it locally to `~/.config/nvim/doc/lilvim.txt` for offline
access.

Once you have the docs locally, you can view them from the command line via
`nvim -c 'help lilvim | only'` or inside of Neovim via `:help lilvim`. Note
that you can jump directly to a module's help page via `:help lil-edit` etc.

## Modules

- [lil-edit](lua/lil-edit.lua)
- [lil-lsp](lua/lil-lsp.lua)
- [lil-places](lua/lil-places.lua)
- [lil-quickfix](lua/lil-quickfix.lua)
- [lil-search](lua/lil-search.lua)
- [lil-stats](lua/lil-stats.lua)
- [lil-subs](lua/lil-subs.lua)
- [lil-toggle](lua/lil-toggle.lua)

_For not-so-lil module extensions, head over to our
[wiki](https://github.com/mvllow/lilvim/wiki)_

## Principles

> Heavily inspired by [Rational Emacs](https://github.com/SystemCrafters/rational-emacs)

### Minimal and modular by design

Lilvim includes several self-contained modules which handle their own vim
options, keymaps and configurations. This approach differs from the common
practice of separating functionality by plugin.

### Prioritise built-in Neovim functionality

We demonstrate Neovim's built-in capabilities and lower the platform's barrier
to entry for new users. This lightweight approach encourages users to first
understand the platform's features before adding plugins.

## Related

If you're looking for a more robust starting point for your own config, check
out [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It provides
an excellent foundation with detailed explanations of each component.

For users seeking a batteries-included experience, consider:

- [LazyVim](https://github.com/LazyVim/LazyVim) - Modern and feature-rich
  config
- [AstroVim](https://github.com/kabinspace/AstroVim) - Beautiful and
  customisable environment

## Contributing

We welcome and appreciate contributions of any kind. Please open an issue to
discuss the addition of new modules.
