---@type LazySpec
return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    { '<leader>y', '<cmd>Yazi<cr>', mode = { 'n', 'v' }, desc = 'Open yazi at the current file' },
    { '<leader>Y', '<cmd>Yazi cwd<cr>', desc = "Open yazi in nvim's working directory" },
    { '<leader>-', '<cmd>Yazi toggle<cr>', desc = 'Resume the last yazi session' },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = false,
    keymaps = { show_help = '<f1>' },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
