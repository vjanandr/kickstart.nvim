return {
  -- Override LazyVim default colorscheme
  {
    'dhananjaylatkar/cscope_maps.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' }, -- optional, for nice picker UI
    config = function()
      require('cscope_maps').setup {
        cscope = {
          exec = 'cscope', -- "cscope" or "gtags-cscope"
          db_file = 'cscope.out',
          picker = 'telescope', -- "quickfix", "telescope", "fzf-lua"
          skip_picker_for_single_result = true,
          -- project_root = vim.fn.getcwd(), -- defaults to current dir
        },
      }
    end,
  },
  {
    'ggandor/leap.nvim',
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gS', '<Plug>(leap-backward)')
    end,
  },
  {
    'folke/trouble.nvim',
    opts = { use_diagnostic_signs = true },
    keys = {
      -- disable conflicting <leader>c* keys
      { '<leader>cs', false },
      { '<leader>cS', false }, -- THIS is the one you still see
      { '<leader>cl', false },
      { '<leader>cL', false },
      { '<leader>cd', false },
      { '<leader>cD', false },

      -- (optional) put Trouble on <leader>t* instead
      { '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>tt', '<cmd>Trouble toggle<cr>', desc = 'Trouble: toggle' },
      { '<leader>td', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Trouble: diagnostics' },
      { '<leader>tq', '<cmd>Trouble qflist toggle<cr>', desc = 'Trouble: quickfix' },
    },
  },
  {
    'akinsho/bufferline.nvim',
    opts = {
      options = {
        numbers = 'ordinal', -- Shows buffer numbers (1, 2, 3, etc.)
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        separator_style = 'slant',
      },
    },
  },
  -- GitHub Copilot AI Code Completion
  {
    'github/copilot.vim',
    event = 'BufEnter',
    config = function()
      -- Enable Copilot by default
      vim.g.copilot_enabled = true

      -- Set up keybindings for Copilot
      vim.keymap.set('i', '<C-g>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
      vim.keymap.set('i', '<C-j>', 'copilot#Next()', { expr = true, silent = true })
      vim.keymap.set('i', '<C-k>', 'copilot#Previous()', { expr = true, silent = true })
      vim.keymap.set('i', '<C-x>', 'copilot#Dismiss()', { expr = true, silent = true })

      -- Manual trigger for completion
      vim.keymap.set('i', '<C-Space>', 'copilot#Suggest()', { expr = true, silent = true })
    end,
  },

  -- Aerial: Code outline sidebar (Tagbar alternative)
  {
    'stevearc/aerial.nvim',
    opts = {
      -- Show all symbols (disable filtering)
      filter_kind = false,
      -- Show guides
      show_guides = true,
      -- Use LSP backend for better symbol detection
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      -- Layout
      layout = {
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 20,
      },
      -- Auto attach to buffers
      attach_mode = 'global',
      -- Highlight current symbol
      highlight_on_hover = true,
    },
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<C-o>', '<cmd>AerialToggle!<cr>', desc = 'Toggle Aerial (symbols sidebar)' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = 'outer',
      mode = 'cursor',
      separator = nil,
      zindex = 20,
    },
  },
}
