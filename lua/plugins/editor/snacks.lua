return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    image = {},
    input = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
    -- explorer = {},
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
                function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list' end,
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
        header = [[
██╗  ██╗ █████╗ ███████╗██╗  ██╗████████╗ █████╗  ██████╗ ████████╗██████╗
██║  ██║██╔══██╗██╔════╝██║  ██║╚══██╔══╝██╔══██╗██╔════╝ ╚══██╔══╝██╔══██╗
███████║███████║███████╗███████║   ██║   ███████║██║  ███╗   ██║   ██████╔╝
██╔══██║██╔══██║╚════██║██╔══██║   ██║   ██╔══██║██║   ██║   ██║   ██╔══██╗
██║  ██║██║  ██║███████║██║  ██║   ██║   ██║  ██║╚██████╔╝   ██║   ██████╔╝
╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═════╝
        ]],
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files()' },
          { icon = ' ', key = 'n', desc = 'New File', action = ':cd ~/Documents/txt/ | ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.picker.grep()' },
          { icon = ' ', key = 'p', desc = 'Projects', action = ':lua Snacks.picker.projects()' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.picker.recent()' },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":execute 'cd' stdpath('config') | lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
          },
          -- { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
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
    -- { '<leader>e', function() Snacks.explorer() end, desc = 'Explorer (root)' },
    -- { '<leader>E', function() Snacks.explorer { cwd = vim.uv.cwd() } end, desc = 'Explorer (cwd)' },
    -- { '<leader>fe', function() Snacks.explorer() end, desc = 'Explorer (root)' },
    -- { '<leader>fE', function() Snacks.explorer { cwd = vim.uv.cwd() } end, desc = 'Explorer (cwd)' },
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
