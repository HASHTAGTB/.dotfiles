return {
  'inzoiniac/renpy-syntax.nvim',
  config = function()
    vim.filetype.add {
      extension = { rpy = 'python' },
    }

    vim.lsp.config('pyright', {
      filetypes = { 'python', 'rpy' },
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
          },
        },
      },
    })

    require('renpy-syntax').setup()
  end,
}
