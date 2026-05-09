return {
  {
    'ahmedkhalf/project.nvim',
    enabled = false,
    event = 'VeryLazy',
    config = function() require('project_nvim').setup() end,
    keys = {
      {
        '<leader>fp',
        function() Snacks.picker.projects() end,
        desc = 'Projects',
      },
    },
  },
}
