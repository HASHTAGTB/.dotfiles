# Neovim Config Redesign — LazyVim Feature Migration

**Date:** 2026-04-30  
**Status:** Approved

## Goal

Upgrade nvim.own (kickstarter-based) by adopting LazyVim's best features: snacks picker/explorer, bufferline, lualine, noice, full blink.cmp, and a clean subfolder plugin structure. Telescope and neo-tree are disabled but kept.

---

## 1. Folder Reorganization

Lazy auto-discovers `lua/plugins/**/*.lua`, so no `init.lua` changes needed.

```
lua/plugins/
  ui/
    bufferline.lua       (new)
    lualine.lua          (new)
    noice.lua            (new)
    tokyonight.lua       (moved)
    transparent.lua      (moved)
    mini-icons.lua       (new)
    smear-cursor.lua     (new)
  editor/
    snacks.lua           (moved + expanded)
    flash.lua            (moved)
    gitsigns.lua         (moved)
    grug-far.lua         (moved)
    which-key.lua        (moved)
    todo-comments.lua    (moved)
    yazi.lua             (moved)
    projects.lua         (moved)
    trouble.lua          (new)
    toggleterm.lua       (new)
    persistence.lua      (new)
  coding/
    blink.lua            (moved + expanded)
    mini-ai.lua          (split from mini.lua)
    mini-surround.lua    (split from mini.lua)
    mini-pairs.lua       (split from mini.lua)
    conform.lua          (moved)
    lint.lua             (moved)
    guess-indent.lua     (moved)
    ts-autotag.lua       (moved)
  lsp/
    lsp.lua              (moved)
    lazydev.lua          (new)
  lang/
    treesitter.lua       (moved)
    flutter.lua          (moved)
    renpy.lua            (moved)
  disabled/
    telescope.lua        (moved + enabled=false)
    neo-tree.lua         (moved + enabled=false)
    mini-statusline.lua  (new, extracted from mini.lua + enabled=false)
```

`mini.lua` is deleted after splitting into three files. `mini.statusline` config is extracted to `disabled/mini-statusline.lua`.

---

## 2. Startup / Loading Events

| Change | Detail |
|---|---|
| `vim.g.have_nerd_font = true` | Enable icons throughout |
| `blink.cmp` event | `VimEnter` → `{ 'InsertEnter', 'CmdlineEnter' }` |
| `bufferline`, `lualine`, `noice` | `event = 'VeryLazy'` |
| `snacks.nvim` | No event (intentionally always-on) |
| LSP plugins | Load on `LspAttach` (already correct) |

---

## 3. Snacks (Picker + Explorer + Dashboard)

`plugins/editor/snacks.lua` — single file for all snacks configuration.

**Features enabled:** `picker`, `explorer`, `dashboard`, `image`, `indent`, `input`, `notifier`, `scope`, `scroll`, `words`.

**Picker keymaps** (replaces telescope):

| Key | Action |
|---|---|
| `<leader>ff` | Find files (root) |
| `<leader>fF` | Find files (cwd) |
| `<leader>fg` | Git files |
| `<leader>fr` | Recent files |
| `<leader>fR` | Recent files (cwd) |
| `<leader>fb` | Buffers |
| `<leader>fp` | Projects |
| `<leader>/` | Grep (root) |
| `<leader>sg` | Grep (root) |
| `<leader>sG` | Grep (cwd) |
| `<leader>sw` | Grep word/selection |
| `<leader>sh` | Help pages |
| `<leader>sk` | Keymaps |
| `<leader>sd` | Diagnostics |
| `<leader>sR` | Resume last picker |
| `<leader>su` | Undotree |
| `<leader>st` | Todo comments |
| `<leader>sT` | Todo/Fix/Fixme |
| `<leader>uC` | Colorschemes |
| `<leader>gs` | Git status |
| `<leader>gd` | Git diff hunks |
| `gd` | LSP definitions |
| `gr` | LSP references |
| `gI` | LSP implementations |
| `gy` | LSP type definitions |
| `<leader>ss` | LSP document symbols |
| `<leader>sS` | LSP workspace symbols |

Flash integration: `<a-s>` in picker window jumps with flash labels.

**Explorer keymaps:**

| Key | Action |
|---|---|
| `<leader>e` / `<leader>fe` | Explorer at root |
| `<leader>E` / `<leader>fE` | Explorer at cwd |

**Dashboard:** `'p'` key updated from `:Telescope projects` to `Snacks.picker.projects()`.

LSP keymaps `gd`/`gr`/`gI`/`gy` move from `telescope.lua`'s LspAttach autocmd into `lsp/lsp.lua`.

---

## 4. Bufferline (`plugins/ui/bufferline.lua`)

Port from LazyVim. `event = 'VeryLazy'`.

Key bindings:
- `<S-h>` / `<S-l>` — cycle prev/next buffer
- `[b` / `]b` — cycle prev/next buffer
- `[B` / `]B` — move buffer prev/next
- `<leader>bp` — toggle pin
- `<leader>bP` — close unpinned buffers
- `<leader>br` / `<leader>bl` — close right/left buffers
- `<leader>bj` — pick buffer

Settings: `diagnostics = 'nvim_lsp'`, `always_show_bufferline = false`, `close_command` uses `Snacks.bufdelete`.

---

## 5. Lualine (`plugins/ui/lualine.lua`)

Port from LazyVim. `event = 'VeryLazy'`. Replaces `mini.statusline`.

Sections:
- `lualine_a`: mode
- `lualine_b`: branch
- `lualine_c`: diagnostics, filetype icon, filename (with relative path) — LazyVim's `root_dir()` and `pretty_path()` helpers are not used since they depend on `LazyVim.util`
- `lualine_x`: lazy updates, git diff (via gitsigns)
- `lualine_y`: progress + location
- `lualine_z`: clock (`os.date('%R')`)

Settings: `theme = 'auto'`, `globalstatus = true`, disabled on `dashboard`/`snacks_dashboard`.

---

## 6. Noice (`plugins/ui/noice.lua`)

`event = 'VeryLazy'`.

Presets: `bottom_search`, `command_palette`, `long_message_to_split`.  
Overrides LSP markdown rendering for styled hover docs.  
Routes noisy save/undo messages to mini view.

Keys:
- `<leader>sn*` — noice history/dismiss
- `<c-f>` / `<c-b>` — scroll LSP hover docs

---

## 7. Blink.cmp (`plugins/coding/blink.lua`)

`event = { 'InsertEnter', 'CmdlineEnter' }`.

| Feature | Setting |
|---|---|
| Sources | `lsp`, `path`, `snippets`, `buffer` |
| Cmdline | enabled, auto-show on `:`, ghost text |
| Ghost text | enabled |
| Auto brackets | enabled |
| Treesitter rendering | LSP items highlighted |
| Auto-show docs | true, 200ms delay |
| Friendly snippets | `rafamadriz/friendly-snippets` dependency |
| Keymap | `preset = 'enter'`, `<C-y>` = accept |
| Signature help | enabled |
| lazydev source | lua filetype only, score_offset = 100 |

---

## 8. New Plugins

| Plugin | File | Purpose |
|---|---|---|
| `folke/lazydev.nvim` | `lsp/lazydev.lua` | Lua LSP + type completion for nvim config |
| `folke/trouble.nvim` | `editor/trouble.lua` | Diagnostics list, LSP results, quickfix UI |
| `echasnovski/mini.icons` | `ui/mini-icons.lua` | Replaces nvim-web-devicons, mocks its API |
| `sphamba/smear-cursor.nvim` | `ui/smear-cursor.lua` | Animated cursor movement |
| `folke/persistence.nvim` | `editor/persistence.lua` | Session save/restore (backs dashboard "Restore Session" key) |
| `akinsho/toggleterm.nvim` | `editor/toggleterm.lua` | Floating/split terminal management |
| `JoosepAlviste/nvim-ts-context-commentstring` | via `lang/treesitter.lua` | Correct comment syntax in embedded languages |

**mini.icons** mocks the `nvim-web-devicons` API so existing plugins that depend on it (bufferline, lualine, etc.) work without changes. `nvim-web-devicons` dependency entries in neo-tree/telescope stay as-is since those are disabled.

---

## 9. Disabled Files

| File | Plugin | Reason |
|---|---|---|
| `disabled/telescope.lua` | telescope.nvim | Replaced by snacks.picker |
| `disabled/neo-tree.lua` | neo-tree.nvim | Replaced by snacks.explorer |
| `disabled/mini-statusline.lua` | mini.statusline | Replaced by lualine |

All three use `enabled = false` at the top level of their return table.
