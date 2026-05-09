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
