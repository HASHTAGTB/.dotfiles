return {
  'nvim-pack/nvim-spectre',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  keys = {
    { '<leader>P', function() require('spectre').toggle() end, desc = 'Toggle Spectre' },
    { '<leader>pw', function() require('spectre').open_visual { select_word = true } end, desc = 'Search current word' },
    { '<leader>pw', function() require('spectre').open_visual() end, mode = 'v', desc = 'Search current word' },
    { '<leader>pp', function() require('spectre').open_file_search { select_word = true } end, desc = 'Search on current file' },
  },
}
