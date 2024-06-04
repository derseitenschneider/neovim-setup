return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    -- import mason
    local mason = require('mason')

    -- import mason-lspconfig
    local mason_lspconfig = require('mason-lspconfig')

    local mason_tool_installer = require('mason-tool-installer')

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        'tsserver',
        'html',
        'cssls',
        'tailwindcss',
        'svelte',
        'lua_ls',
        'graphql',
        'emmet_ls',
        'prismals',
        'pyright',
        'intelephense',
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'biome', -- js/jsx formatter & linter
        'stylua', -- lua formatter
        'isort', -- python formatter
        'black', -- python formatter
        'pylint',
        'phpcs',
        'phpcbf',
      },
    })

    require('lspconfig').biome.setup({

      config = function()
        local capabilities = vim.api.nvim_get_api_info().capabilities
        if capabilities.line_wrapping then
          vim.opt.wrap = true -- Enable line wrapping
          vim.opt.nowrap:append('class') -- Don't wrap within class attributes
        end
      end,
    })
  end,
}
