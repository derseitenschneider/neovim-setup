return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-github.nvim',
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local transform_mod = require('telescope.actions.mt').transform_mod
    local keymap = vim.keymap -- for conciseness
    local trouble = require('trouble')
    local trouble_telescope = require('trouble.providers.telescope')

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function()
        trouble.toggle('quickfix')
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ['<C-t>'] = trouble_telescope.smart_open_with_trouble,
            ['kj'] = actions.close,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension('fzf'))
    pcall(require('telescope').load_extension('ui-select'))
    telescope.load_extension('fzf')

    -- Github cli extension
    telescope.load_extension('gh')
    local gh = require('telescope').extensions.gh

    keymap.set('n', '<leader>ghi', gh.issues, { desc = '[G]it[h]ub [i]ssues' })
    keymap.set('n', '<leader>ghp', gh.pull_request, { desc = '[G]it[h]ub [p]ull requests' })
    keymap.set('n', '<leader>ghg', gh.gist, { desc = '[G]it[h]ub [g]ist' })
    keymap.set('n', '<leader>ghr', gh.run, { desc = '[G]it[h]ub [r]un' })

    -- set keymaps
    local builtin = require('telescope.builtin')

    keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Find string under cursor in cwd' })

    -- Find neovim settings
    keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find todos' })
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = '[S]earch [N]eovim files' })

    -- Find obsidian diretory
    vim.keymap.set('n', '<leader>fo', function()
      builtin.find_files({ cwd = '~/Notes/' })
    end, { desc = '[S]earch [O]bsidian files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
