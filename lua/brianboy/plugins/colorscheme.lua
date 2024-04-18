return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    vim.cmd.colorscheme('catppuccin')
  end,
}
--[[ return {
  'rebelot/kanagawa.nvim',
  name = 'kanagawa',
  priority = 1000,

  config = function()
    vim.cmd.colorscheme('kanagawa')
  end,
} ]]
