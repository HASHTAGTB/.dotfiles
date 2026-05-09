# Neovim Config Restructure Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure nvim.own into a clean subfolder layout and add bufferline, lualine, noice, snacks picker/explorer, full blink.cmp, and 7 new plugins.

**Architecture:** Move all existing plugin files into `lua/plugins/{ui,editor,coding,lsp,lang,disabled}/` subfolders (Lazy auto-discovers them), then expand and add plugins. Each task is one file or one concern and ends with a commit and a headless startup check.

**Tech Stack:** Neovim, Lua, lazy.nvim, snacks.nvim, blink.cmp, lualine, bufferline, noice

---

## Verification command (use after every commit)

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: exit 0, no error lines. If any `Error` lines appear, read them and fix before continuing.

---

## File Map (before → after)

| Before | After |
|---|---|
| `lua/plugins/snacks.lua` | `lua/plugins/editor/snacks.lua` (rewritten) |
| `lua/plugins/blink.lua` | `lua/plugins/coding/blink.lua` (rewritten) |
| `lua/plugins/mini.lua` | deleted — split into 3 files + 1 disabled |
| `lua/plugins/lsp.lua` | `lua/plugins/lsp/lsp.lua` (add snacks LSP keymaps) |
| `lua/plugins/treesitter.lua` | `lua/plugins/lang/treesitter.lua` (add ts-context-commentstring) |
| `lua/plugins/telescope.lua` | `lua/plugins/disabled/telescope.lua` (add `enabled = false`) |
| `lua/plugins/neo-tree.lua` | `lua/plugins/disabled/neo-tree.lua` (add `enabled = false`) |
| `lua/plugins/tokyonight.lua` | `lua/plugins/ui/tokyonight.lua` |
| `lua/plugins/transparent.lua` | `lua/plugins/ui/transparent.lua` |
| `lua/plugins/flash.lua` | `lua/plugins/editor/flash.lua` |
| `lua/plugins/gitsigns.lua` | `lua/plugins/editor/gitsigns.lua` |
| `lua/plugins/grug-far.lua` | `lua/plugins/editor/grug-far.lua` |
| `lua/plugins/which-key.lua` | `lua/plugins/editor/which-key.lua` |
| `lua/plugins/todo-comments.lua` | `lua/plugins/editor/todo-comments.lua` |
| `lua/plugins/yazi.lua` | `lua/plugins/editor/yazi.lua` |
| `lua/plugins/projects.lua` | `lua/plugins/editor/projects.lua` |
| `lua/plugins/conform.lua` | `lua/plugins/coding/conform.lua` |
| `lua/plugins/lint.lua` | `lua/plugins/coding/lint.lua` |
| `lua/plugins/guess-indent.lua` | `lua/plugins/coding/guess-indent.lua` |
| `lua/plugins/ts-autotag.lua` | `lua/plugins/coding/ts-autotag.lua` |
| `lua/plugins/flutter.lua` | `lua/plugins/lang/flutter.lua` |
| `lua/plugins/renpy.lua` | `lua/plugins/lang/renpy.lua` |
| *(new)* | `lua/plugins/ui/bufferline.lua` |
| *(new)* | `lua/plugins/ui/lualine.lua` |
| *(new)* | `lua/plugins/ui/noice.lua` |
| *(new)* | `lua/plugins/ui/mini-icons.lua` |
| *(new)* | `lua/plugins/ui/smear-cursor.lua` |
| *(new)* | `lua/plugins/editor/trouble.lua` |
| *(new)* | `lua/plugins/editor/persistence.lua` |
| *(new)* | `lua/plugins/editor/toggleterm.lua` |
| *(new)* | `lua/plugins/coding/mini-ai.lua` |
| *(new)* | `lua/plugins/coding/mini-surround.lua` |
| *(new)* | `lua/plugins/coding/mini-pairs.lua` |
| *(new)* | `lua/plugins/lsp/lazydev.lua` |
| *(new)* | `lua/plugins/disabled/mini-statusline.lua` |

---

## Task 1: Enable Nerd Font

**Files:**
- Modify: `lua/config/options.lua:1`

- [ ] **Step 1: Change have_nerd_font to true**

In `lua/config/options.lua`, change line 1:

```lua
vim.g.have_nerd_font = true
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/config/options.lua
git commit -m "feat: enable nerd font"
```

---

## Task 2: Create Subfolder Structure and Move Files

**Files:** All existing plugin files (moved, not edited)

- [ ] **Step 1: Create subfolders**

```bash
mkdir -p lua/plugins/ui
mkdir -p lua/plugins/editor
mkdir -p lua/plugins/coding
mkdir -p lua/plugins/lsp
mkdir -p lua/plugins/lang
mkdir -p lua/plugins/disabled
```

- [ ] **Step 2: Move UI files**

```bash
git mv lua/plugins/tokyonight.lua lua/plugins/ui/tokyonight.lua
git mv lua/plugins/transparent.lua lua/plugins/ui/transparent.lua
```

- [ ] **Step 3: Move editor files**

```bash
git mv lua/plugins/snacks.lua lua/plugins/editor/snacks.lua
git mv lua/plugins/flash.lua lua/plugins/editor/flash.lua
git mv lua/plugins/gitsigns.lua lua/plugins/editor/gitsigns.lua
git mv lua/plugins/grug-far.lua lua/plugins/editor/grug-far.lua
git mv lua/plugins/which-key.lua lua/plugins/editor/which-key.lua
git mv lua/plugins/todo-comments.lua lua/plugins/editor/todo-comments.lua
git mv lua/plugins/yazi.lua lua/plugins/editor/yazi.lua
git mv lua/plugins/projects.lua lua/plugins/editor/projects.lua
```

- [ ] **Step 4: Move coding files**

```bash
git mv lua/plugins/blink.lua lua/plugins/coding/blink.lua
git mv lua/plugins/conform.lua lua/plugins/coding/conform.lua
git mv lua/plugins/lint.lua lua/plugins/coding/lint.lua
git mv lua/plugins/guess-indent.lua lua/plugins/coding/guess-indent.lua
git mv lua/plugins/ts-autotag.lua lua/plugins/coding/ts-autotag.lua
```

- [ ] **Step 5: Move lsp and lang files**

```bash
git mv lua/plugins/lsp.lua lua/plugins/lsp/lsp.lua
git mv lua/plugins/treesitter.lua lua/plugins/lang/treesitter.lua
git mv lua/plugins/flutter.lua lua/plugins/lang/flutter.lua
git mv lua/plugins/renpy.lua lua/plugins/lang/renpy.lua
```

- [ ] **Step 6: Move disabled files**

```bash
git mv lua/plugins/telescope.lua lua/plugins/disabled/telescope.lua
git mv lua/plugins/neo-tree.lua lua/plugins/disabled/neo-tree.lua
```

- [ ] **Step 7: Verify Lazy still discovers all plugins**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 8: Commit**

```bash
git add -A
git commit -m "refactor: move plugins into ui/editor/coding/lsp/lang/disabled subfolders"
```

---

## Task 3: Disable Telescope and Neo-tree

**Files:**
- Modify: `lua/plugins/disabled/telescope.lua`
- Modify: `lua/plugins/disabled/neo-tree.lua`

- [ ] **Step 1: Add `enabled = false` to telescope.lua**

In `lua/plugins/disabled/telescope.lua`, change the return table opening from:

```lua
return {
  'nvim-telescope/telescope.nvim',
```

to:

```lua
return {
  'nvim-telescope/telescope.nvim',
  enabled = false,
```

- [ ] **Step 2: Add `enabled = false` to neo-tree.lua**

In `lua/plugins/disabled/neo-tree.lua`, change the return table opening from:

```lua
return {
  'nvim-neo-tree/neo-tree.nvim',
```

to:

```lua
return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = false,
```

- [ ] **Step 3: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 4: Commit**

```bash
git add lua/plugins/disabled/telescope.lua lua/plugins/disabled/neo-tree.lua
git commit -m "feat: disable telescope and neo-tree (replaced by snacks)"
```

---

## Task 4: Split mini.lua into Separate Files

**Files:**
- Create: `lua/plugins/coding/mini-ai.lua`
- Create: `lua/plugins/coding/mini-surround.lua`
- Create: `lua/plugins/coding/mini-pairs.lua`
- Create: `lua/plugins/disabled/mini-statusline.lua`
- Delete: `lua/plugins/mini.lua`

- [ ] **Step 1: Create mini-ai.lua**

```lua
-- lua/plugins/coding/mini-ai.lua
return {
  'echasnovski/mini.ai',
  event = 'VeryLazy',
  opts = function()
    local ai = require 'mini.ai'
    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter {
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        },
        f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
        c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        d = { '%f[%d]%d+' },
        e = {
          { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
          '^().*()$',
        },
        u = ai.gen_spec.function_call(),
        U = ai.gen_spec.function_call { name_pattern = '[%w_]' },
      },
    }
  end,
}
```

- [ ] **Step 2: Create mini-surround.lua**

```lua
-- lua/plugins/coding/mini-surround.lua
return {
  'echasnovski/mini.surround',
  event = 'VeryLazy',
  opts = {},
}
```

- [ ] **Step 3: Create mini-pairs.lua**

```lua
-- lua/plugins/coding/mini-pairs.lua
return {
  'echasnovski/mini.pairs',
  event = 'VeryLazy',
  opts = {
    modes = { insert = true, command = true, terminal = false },
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_ts = { 'string' },
    skip_unbalanced = true,
    markdown = true,
  },
}
```

- [ ] **Step 4: Create disabled/mini-statusline.lua**

```lua
-- lua/plugins/disabled/mini-statusline.lua
return {
  'echasnovski/mini.statusline',
  enabled = false,
  opts = { use_icons = true },
}
```

- [ ] **Step 5: Delete mini.lua**

```bash
git rm lua/plugins/mini.lua
```

- [ ] **Step 6: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`. Note: mini.ai, mini.surround, mini.pairs will install fresh on next `:Lazy sync` — they're now using individual echasnovski repos instead of the monorepo.

- [ ] **Step 7: Commit**

```bash
git add lua/plugins/coding/mini-ai.lua lua/plugins/coding/mini-surround.lua lua/plugins/coding/mini-pairs.lua lua/plugins/disabled/mini-statusline.lua
git commit -m "refactor: split mini.lua into separate files, add mini-statusline to disabled"
```

---

## Task 5: Expand Snacks (Picker + Explorer + All Features)

**Files:**
- Rewrite: `lua/plugins/editor/snacks.lua`

- [ ] **Step 1: Rewrite snacks.lua**

Replace the entire content of `lua/plugins/editor/snacks.lua` with:

```lua
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    image = {},
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
    explorer = {},
    picker = {
      win = {
        input = {
          keys = {
            ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
            ['s'] = { 'flash' },
          },
        },
      },
      actions = {
        flash = function(picker)
          require('flash').jump {
            pattern = '^',
            label = { after = { 0, 0 } },
            search = {
              mode = 'search',
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          }
        end,
      },
    },
    dashboard = {
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.picker.files()" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.picker.grep()" },
          { icon = ' ', key = 'p', desc = 'Projects', action = ':lua Snacks.picker.projects()' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.picker.recent()" },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },
  },
  keys = {
    -- notifications
    { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
    -- find
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>fF', function() Snacks.picker.files { cwd = vim.uv.cwd() } end, desc = 'Find Files (cwd)' },
    { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent Files' },
    { '<leader>fR', function() Snacks.picker.recent { filter = { cwd = true } } end, desc = 'Recent Files (cwd)' },
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
    -- explorer
    { '<leader>e', function() Snacks.explorer() end, desc = 'Explorer (root)' },
    { '<leader>E', function() Snacks.explorer { cwd = vim.uv.cwd() } end, desc = 'Explorer (cwd)' },
    { '<leader>fe', function() Snacks.explorer() end, desc = 'Explorer (root)' },
    { '<leader>fE', function() Snacks.explorer { cwd = vim.uv.cwd() } end, desc = 'Explorer (cwd)' },
    -- grep
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep (root)' },
    { '<leader>sG', function() Snacks.picker.grep { cwd = vim.uv.cwd() } end, desc = 'Grep (cwd)' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, mode = { 'n', 'x' }, desc = 'Grep Word' },
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    -- search
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undotree' },
    { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    -- todo-comments integration (requires todo-comments.nvim)
    { '<leader>st', function() Snacks.picker.todo_comments() end, desc = 'Todo Comments' },
    { '<leader>sT', function() Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } } end, desc = 'Todo/Fix/Fixme' },
    -- ui
    { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
    -- git
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
    { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff' },
    -- word navigation
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
  },
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/editor/snacks.lua
git commit -m "feat: expand snacks with picker, explorer, notifier, indent, scroll, words"
```

---

## Task 6: Update lsp.lua — Add Snacks Picker LSP Keymaps

**Files:**
- Modify: `lua/plugins/lsp/lsp.lua`

The current `lsp.lua` has a `LspAttach` callback with `grn`, `gra`, `grD`. We need to add `gd`, `gr`, `gI`, `gy`, `<leader>ss`, `<leader>sS` using `Snacks.picker.*`.

- [ ] **Step 1: Add snacks picker LSP keymaps inside the LspAttach callback**

In `lua/plugins/lsp/lsp.lua`, inside the `LspAttach` callback after the existing `map('grD', ...)` line, add:

```lua
        -- snacks picker LSP keymaps
        map('gd', function() Snacks.picker.lsp_definitions() end, '[G]oto [D]efinition')
        map('gr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
        map('gI', function() Snacks.picker.lsp_implementations() end, '[G]oto [I]mplementation')
        map('gy', function() Snacks.picker.lsp_type_definitions() end, '[G]oto T[y]pe Definition')
        map('<leader>ss', function() Snacks.picker.lsp_symbols() end, '[S]earch [S]ymbols')
        map('<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, '[S]earch Workspace [S]ymbols')
```

The full LspAttach callback should look like:

```lua
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- snacks picker LSP keymaps
        map('gd', function() Snacks.picker.lsp_definitions() end, '[G]oto [D]efinition')
        map('gr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
        map('gI', function() Snacks.picker.lsp_implementations() end, '[G]oto [I]mplementation')
        map('gy', function() Snacks.picker.lsp_type_definitions() end, '[G]oto T[y]pe Definition')
        map('<leader>ss', function() Snacks.picker.lsp_symbols() end, '[S]earch [S]ymbols')
        map('<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, '[S]earch Workspace [S]ymbols')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
          -- ... (rest of existing code unchanged)
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/lsp/lsp.lua
git commit -m "feat: add snacks picker LSP keymaps (gd, gr, gI, gy, ss, sS)"
```

---

## Task 7: Add Bufferline

**Files:**
- Create: `lua/plugins/ui/bufferline.lua`

- [ ] **Step 1: Create bufferline.lua**

```lua
-- lua/plugins/ui/bufferline.lua
return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move Buffer Prev' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move Buffer Next' },
    { '<leader>bj', '<cmd>BufferLinePick<cr>', desc = 'Pick Buffer' },
  },
  opts = {
    options = {
      close_command = function(n) Snacks.bufdelete(n) end,
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local ret = (diag.error and ' ' .. diag.error .. ' ' or '')
          .. (diag.warning and ' ' .. diag.warning or '')
        return vim.trim(ret)
      end,
      offsets = {
        { filetype = 'snacks_layout_box' },
      },
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
      callback = function()
        vim.schedule(function() pcall(nvim_bufferline) end)
      end,
    })
  end,
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/ui/bufferline.lua
git commit -m "feat: add bufferline with Snacks.bufdelete and LSP diagnostics"
```

---

## Task 8: Add Lualine

**Files:**
- Create: `lua/plugins/ui/lualine.lua`

- [ ] **Step 1: Create lualine.lua**

```lua
-- lua/plugins/ui/lualine.lua
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = ' '
    else
      vim.o.laststatus = 0
    end
  end,
  opts = {
    options = {
      theme = 'auto',
      globalstatus = true,
      disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'snacks_dashboard' } },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = {
        { 'diagnostics' },
        { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
        { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
      },
      lualine_x = {
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = { fg = '#ff9e64' },
        },
        {
          'diff',
          symbols = { added = ' ', modified = ' ', removed = ' ' },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      },
      lualine_y = {
        { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
        { 'location', padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        function() return ' ' .. os.date '%R' end,
      },
    },
    extensions = { 'lazy' },
  },
  config = function(_, opts)
    vim.o.laststatus = vim.g.lualine_laststatus
    require('lualine').setup(opts)
  end,
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/ui/lualine.lua
git commit -m "feat: add lualine with gitsigns diff, lazy updates, and clock"
```

---

## Task 9: Add Noice

**Files:**
- Create: `lua/plugins/ui/noice.lua`

- [ ] **Step 1: Create noice.lua**

```lua
-- lua/plugins/ui/noice.lua
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'mini',
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  },
  keys = {
    { '<leader>sn', '', desc = '+noice' },
    { '<S-Enter>', function() require('noice').redirect(vim.fn.getcmdline()) end, mode = 'c', desc = 'Redirect Cmdline' },
    { '<leader>snl', function() require('noice').cmd 'last' end, desc = 'Noice Last Message' },
    { '<leader>snh', function() require('noice').cmd 'history' end, desc = 'Noice History' },
    { '<leader>sna', function() require('noice').cmd 'all' end, desc = 'Noice All' },
    { '<leader>snd', function() require('noice').cmd 'dismiss' end, desc = 'Dismiss All' },
    { '<c-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, silent = true, expr = true, desc = 'Scroll Forward', mode = { 'i', 'n', 's' } },
    { '<c-b>', function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end, silent = true, expr = true, desc = 'Scroll Backward', mode = { 'i', 'n', 's' } },
  },
  config = function(_, opts)
    if vim.o.filetype == 'lazy' then vim.cmd [[messages clear]] end
    require('noice').setup(opts)
  end,
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/ui/noice.lua
git commit -m "feat: add noice for fancy cmdline, messages, and LSP hover"
```

---

## Task 10: Add Mini Icons

**Files:**
- Create: `lua/plugins/ui/mini-icons.lua`

- [ ] **Step 1: Create mini-icons.lua**

```lua
-- lua/plugins/ui/mini-icons.lua
return {
  'echasnovski/mini.icons',
  lazy = true,
  opts = {
    file = {
      ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
    },
    filetype = {
      dotenv = { glyph = '', hl = 'MiniIconsYellow' },
    },
  },
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/ui/mini-icons.lua
git commit -m "feat: add mini.icons as nvim-web-devicons replacement"
```

---

## Task 11: Add Smear Cursor

**Files:**
- Create: `lua/plugins/ui/smear-cursor.lua`

- [ ] **Step 1: Create smear-cursor.lua**

```lua
-- lua/plugins/ui/smear-cursor.lua
return {
  'sphamba/smear-cursor.nvim',
  event = 'VeryLazy',
  opts = {},
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/ui/smear-cursor.lua
git commit -m "feat: add smear-cursor for animated cursor movement"
```

---

## Task 12: Expand Blink.cmp

**Files:**
- Rewrite: `lua/plugins/coding/blink.lua`

- [ ] **Step 1: Rewrite blink.lua with full feature set**

Replace entire content of `lua/plugins/coding/blink.lua`:

```lua
-- lua/plugins/coding/blink.lua
return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
        return 'make install_jsregexp'
      end)(),
      opts = {},
    },
    'rafamadriz/friendly-snippets',
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',
      ['<C-y>'] = { 'select_and_accept' },
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = { treesitter = { 'lsp' } },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = { enabled = true },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
    cmdline = {
      enabled = true,
      keymap = {
        preset = 'cmdline',
        ['<Right>'] = false,
        ['<Left>'] = false,
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function() return vim.fn.getcmdtype() == ':' end,
        },
        ghost_text = { enabled = true },
      },
    },
  },
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/coding/blink.lua
git commit -m "feat: expand blink.cmp with buffer source, cmdline, ghost text, auto-brackets, signature"
```

---

## Task 13: Add Lazydev

**Files:**
- Create: `lua/plugins/lsp/lazydev.lua`

- [ ] **Step 1: Create lazydev.lua**

```lua
-- lua/plugins/lsp/lazydev.lua
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/lsp/lazydev.lua
git commit -m "feat: add lazydev for Lua LSP completion in nvim config"
```

---

## Task 14: Add Trouble

**Files:**
- Create: `lua/plugins/editor/trouble.lua`

- [ ] **Step 1: Create trouble.lua**

```lua
-- lua/plugins/editor/trouble.lua
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = { use_diagnostic_signs = true },
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
    { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP References (Trouble)' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
  },
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/editor/trouble.lua
git commit -m "feat: add trouble.nvim for diagnostics and LSP results UI"
```

---

## Task 15: Add Persistence

**Files:**
- Create: `lua/plugins/editor/persistence.lua`

- [ ] **Step 1: Create persistence.lua**

```lua
-- lua/plugins/editor/persistence.lua
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    { '<leader>qs', function() require('persistence').load() end, desc = 'Restore Session' },
    { '<leader>qS', function() require('persistence').select() end, desc = 'Select Session' },
    { '<leader>ql', function() require('persistence').load { last = true } end, desc = 'Restore Last Session' },
    { '<leader>qd', function() require('persistence').stop() end, desc = "Don't Save Current Session" },
  },
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/editor/persistence.lua
git commit -m "feat: add persistence.nvim for session save/restore"
```

---

## Task 16: Add Toggleterm

**Files:**
- Create: `lua/plugins/editor/toggleterm.lua`

Note: `<leader>th` is already used by inlay hints in `lsp/lsp.lua`. Toggleterm uses `<c-\>` as its main toggle and `<leader>tf/ts/tv` for direction-specific opens.

- [ ] **Step 1: Create toggleterm.lua**

```lua
-- lua/plugins/editor/toggleterm.lua
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Terminal (float)' },
    { '<leader>ts', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Terminal (horizontal split)' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<cr>', desc = 'Terminal (vertical split)' },
  },
  opts = {
    open_mapping = [[<c-\>]],
    direction = 'float',
    float_opts = { border = 'curved' },
  },
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/editor/toggleterm.lua
git commit -m "feat: add toggleterm for floating/split terminal management"
```

---

## Task 17: Add ts-context-commentstring to Treesitter

**Files:**
- Modify: `lua/plugins/lang/treesitter.lua`

- [ ] **Step 1: Add ts-context-commentstring as a dependency**

In `lua/plugins/lang/treesitter.lua`, add a `dependencies` field after the opening of the return table (before `lazy = false`):

```lua
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = { enable_autocmd = false },
    },
  },
  config = function()
    local parsers = {
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline',
      'query', 'vim', 'vimdoc', 'svelte', 'javascript', 'typescript', 'css',
    }
    require('nvim-treesitter').install(parsers)

    -- use context-aware commentstring (correct syntax in JSX, Svelte, HTML templates)
    vim.g.skip_ts_context_commentstring_module = true
    require('ts_context_commentstring').setup { enable_autocmd = false }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end
        if not vim.treesitter.language.add(language) then return end
        vim.treesitter.start(buf, language)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
```

- [ ] **Step 2: Verify startup**

```bash
nvim --headless -c "q" 2>&1; echo "exit: $?"
```

Expected: `exit: 0`

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/lang/treesitter.lua
git commit -m "feat: add nvim-ts-context-commentstring for context-aware comments"
```

---

## Task 18: Sync Plugins and Verify

- [ ] **Step 1: Run Lazy sync to install all new plugins**

Open Neovim and run:

```
:Lazy sync
```

Wait for all plugins to install. Expected new installs: `bufferline.nvim`, `lualine.nvim`, `noice.nvim`, `nui.nvim`, `mini.icons`, `smear-cursor.nvim`, `trouble.nvim`, `persistence.nvim`, `toggleterm.nvim`, `mini.ai`, `mini.surround`, `mini.pairs`, `lazydev.nvim`, `nvim-ts-context-commentstring`, `friendly-snippets`, `snacks.nvim` (update).

- [ ] **Step 2: Clean up old plugins**

```
:Lazy clean
```

This removes `nvim-mini/mini.nvim` and `nvim-mini/mini.pairs` (replaced by individual echasnovski packages) and any other now-unused plugins.

- [ ] **Step 3: Verify core features**

Open Neovim and check each feature:

| Feature | How to verify |
|---|---|
| Nerd font icons | Bufferline and lualine show icons |
| Bufferline | Open 2+ files, tabs appear at top |
| Lualine | Status bar shows mode, branch, filename, clock |
| Noice | Press `:` — command palette appears as floating window |
| Snacks picker | Press `<leader>ff` — file picker opens |
| Snacks explorer | Press `<leader>e` — file tree opens in sidebar |
| Snacks dashboard | Open `nvim` with no args — dashboard shows |
| Blink cmdline | Press `:` and type — completions appear |
| Blink ghost text | Open a file and start typing — inline suggestion appears |
| Blink signature | Call a function — signature popup shows |
| Trouble | Press `<leader>xx` — diagnostics window opens |
| Persistence | Open files, quit, reopen nvim, press `<leader>qs` — session restores |
| Toggleterm | Press `<c-\>` — floating terminal opens |
| Smear cursor | Move cursor — animated trail appears |
| LSP gd/gr | With LSP active, `gd` opens definitions in picker |
| Flash in picker | Press `<leader>ff`, then `s` — flash labels appear on results |
| Mini.ai | In normal mode, `vif` selects inner function |
| Mini.surround | `sa"` surrounds with quotes |

- [ ] **Step 4: Final commit (lock file)**

```bash
git add lazy-lock.json
git commit -m "chore: update lazy-lock after plugin sync and restructure"
```
