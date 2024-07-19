return {
  'praem90/nvim-phpcsf',
  config = function()
    vim.g.nvim_phpcs_config_phpcs_path = 'phpcs'
    vim.g.nvim_phpcs_config_phpcbf_path = 'phpcbf'

    -- Setup auto formatting for php files using phpcs
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('PHPCSGroup', { clear = true }),
      pattern = '*.php',
      command = 'lua require\'phpcs\'.cs()',
    })

    vim.api.nvim_create_autocmd('BufWritePost', {
      group = vim.api.nvim_create_augroup('PHPCSGroup', { clear = true }),
      pattern = '*.php',
      command = 'lua require\'phpcs\'.cbf()',
    })

    vim.keymap.set('n', '<leader>lp', function()
      require('phpcs').cbf()
    end, {
      silent = true,
      noremap = true,
      desc = 'PHP Fix',
    })
    vim.g.nvim_phpcs_config_phpcs_standard = 'WordPress'
  end,
}
