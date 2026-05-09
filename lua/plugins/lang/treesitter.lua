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
