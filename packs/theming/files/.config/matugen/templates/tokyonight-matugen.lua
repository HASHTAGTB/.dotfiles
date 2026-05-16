return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      style = 'night',
      on_colors = function(colors)
        -- Backgrounds
        colors.bg = '{{ colors.background.dark.hex }}'
        colors.bg_dark = '{{ colors.surface.dark.hex }}'
        colors.bg_dark1 = '{{ colors.scrim.dark.hex }}'
        colors.bg_float = '{{ colors.surface.dark.hex }}'
        colors.bg_highlight = '{{ colors.surface_variant.dark.hex }}'
        colors.bg_popup = '{{ colors.surface.dark.hex }}'
        colors.bg_search = '{{ colors.primary_container.dark.hex }}'
        colors.bg_sidebar = '{{ colors.surface.dark.hex }}'
        colors.bg_statusline = '{{ colors.surface.dark.hex }}'
        colors.bg_visual = '{{ colors.primary_container.dark.hex }}'
        colors.black = '{{ colors.shadow.dark.hex }}'

        -- Borders
        colors.border = '{{ colors.shadow.dark.hex }}'
        colors.border_highlight = '{{ colors.outline.dark.hex }}'

        -- Foregrounds
        colors.fg = '{{ colors.on_background.dark.hex }}'
        colors.fg_dark = '{{ colors.on_surface.dark.hex }}'
        colors.fg_float = '{{ colors.on_surface.dark.hex }}'
        colors.fg_gutter = '{{ colors.outline_variant.dark.hex }}'
        colors.fg_sidebar = '{{ colors.on_surface_variant.dark.hex }}'

        -- Muted text tiers
        colors.comment = '{{ colors.on_surface_variant.dark.hex }}'
        colors.dark3 = '{{ colors.outline.dark.hex }}'
        colors.dark5 = '{{ colors.on_surface_variant.dark.hex }}'

        -- Semantic / diagnostic
        colors.error = '{{ colors.error.dark.hex }}'
        colors.hint = '{{ colors.tertiary.dark.hex }}'
        colors.info = '{{ colors.secondary.dark.hex }}'
        colors.warning = '{{ colors.tertiary_container.dark.hex }}'
        colors.todo = '{{ colors.primary.dark.hex }}'

        -- Terminal
        colors.terminal_black = '{{ colors.surface_variant.dark.hex }}'

        -- Diff gutters / backgrounds
        colors.diff = {
          add = '{{ colors.primary_container.dark.hex }}',
          change = '{{ colors.secondary_container.dark.hex }}',
          delete = '{{ colors.on_error.dark.hex }}',
          text = '{{ colors.on_primary_container.dark.hex }}',
        }

        -- Git signs
        colors.git = {
          add = '{{ colors.primary.dark.hex }}',
          change = '{{ colors.secondary.dark.hex }}',
          delete = '{{ colors.error.dark.hex }}',
          ignore = '{{ colors.outline.dark.hex }}',
        }
      end,
    }
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
