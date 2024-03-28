return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'
    conform.setup {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        javascript = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    }
    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      }
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
