return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'neovim/nvim-lspconfig',  -- Add this dependency
  },
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')
    local lspconfig = require('lspconfig')

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
      automatic_installation = true,
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

    -- Setup LSP servers after mason-lspconfig
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({})
      end,
      ['biome'] = function()
        lspconfig.biome.setup({
          on_attach = function(client, bufnr)
            local capabilities = client.server.capabilities
            if capabilities.documentFormattingProvider then
              vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
            end
          end,
        })
      end,
    })
  end,
}
