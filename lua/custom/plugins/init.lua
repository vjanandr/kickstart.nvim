return {
  -- Override LazyVim default colorscheme
  {
    url = 'https://codeberg.org/andyg/leap.nvim',
    keys = {
      { 'gs', '<Plug>(leap-forward)', mode = { 'n', 'x', 'o' }, desc = 'Leap forward' },
      { 'gS', '<Plug>(leap-backward)', mode = { 'n', 'x', 'o' }, desc = 'Leap backward' },
    },
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
    event = 'VeryLazy',
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
    -- Load on demand via <C-o> instead of at startup.
    keys = {
      { '<C-o>', '<cmd>AerialToggle!<cr>', desc = 'Toggle Aerial (symbols sidebar)' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    -- Load when a file is opened rather than right after startup.
    event = { 'BufReadPost', 'BufNewFile' },
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
  {
    'dkarter/bullets.vim',
    ft = { 'markdown', 'text' },
    init = function()
      -- Enable bullets inside table cells
      vim.g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit' }
      vim.g.bullets_enable_in_empty_buffers = 0
      -- Don't delete bullets when pressing backspace on empty line
      vim.g.bullets_delete_last_bullet_if_empty = 0
      -- Allow bullets and lists within table cells
      vim.g.bullets_custom_mappings = {
        { 'imap', '<CR>', '<Plug>(bullets-newline)' },
        { 'nmap', 'o', '<Plug>(bullets-newline)' },
      }
    end,
  },
  {
    'folke/zen-mode.nvim',
    keys = {
      { '<leader>nz', function() require('zen-mode').toggle() end, desc = 'Notes: Zen mode' },
    },
    opts = {
      window = {
        backdrop = 0.95,
        width = 0.6,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = 'no',
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = '0',
        },
      },
    },
  },
  {
    'dhruvasagar/vim-table-mode',
    init = function()
      vim.g.table_mode_auto_align = 1
    end,
    keys = {
      { '<leader>t[', '<Plug>(table-mode-insert-column-before)', mode = 'n', desc = 'Table: insert column before' },
      { '<leader>t]', '<Plug>(table-mode-insert-column-after)', mode = 'n', desc = 'Table: insert column after' },
    },
  },
  {
    'MattesGroeger/vim-bookmarks',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      vim.g.bookmark_save_per_working_dir = 1
      vim.g.bookmark_auto_save = 1
      vim.g.bookmark_highlight_lines = 0
      vim.api.nvim_create_user_command('BookmarkHighlightToggle', function()
        local v = vim.g.bookmark_highlight_lines or 0
        v = (v == 0) and 1 or 0
        vim.g.bookmark_highlight_lines = v
        vim.notify('Bookmark line highlight: ' .. (v == 1 and 'ON' or 'OFF'))
      end, { desc = 'Toggle vim-bookmarks line highlighting' })
    end,
  },
  {
    'tom-anders/telescope-vim-bookmarks.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'MattesGroeger/vim-bookmarks' },
    config = function()
      pcall(require('telescope').load_extension, 'vim_bookmarks')
    end,
    keys = {
      { '<leader>bm', function() require('telescope').extensions.vim_bookmarks.all() end, desc = 'Bookmarks: list all' },
      { '<leader>bf', function() require('telescope').extensions.vim_bookmarks.current_file() end, desc = 'Bookmarks: current file' },
    },
  },
  { -- Quickfix enhancements for large result sets
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {},
  },
  { -- Highlight search matches with counts
    'kevinhwang91/nvim-hlslens',
    -- Load on the first search (`/` or `?`) instead of at startup.
    event = { 'CmdlineEnter /', 'CmdlineEnter ?' },
    config = function()
      require('hlslens').setup {}
    end,
  },

  { -- Basic highlighting for .log files
    'mtdl9/vim-log-highlighting',
    ft = { 'log', 'text' },
  },
  { -- Session management
    'folke/persistence.nvim',
    opts = {},
    keys = {
      { '<leader>qs', function() require('persistence').load() end, desc = 'Session: restore' },
      { '<leader>ql', function() require('persistence').load { last = true } end, desc = 'Session: restore last' },
      { '<leader>qd', function() require('persistence').stop() end, desc = 'Session: stop' },
    },
  },
  { -- Integrated terminal (great for tail -f)
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = { open_mapping = [[<c-\>]], direction = 'float' },
    keys = {
      { '<leader>to', '<cmd>ToggleTerm<cr>', desc = 'Terminal: toggle' },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    config = function()
      local ok, telescope = pcall(require, 'telescope')
      if ok then
        pcall(telescope.load_extension, 'fzf')
        pcall(telescope.load_extension, 'live_grep_args')
      end
    end,
    keys = {
      {
        '<leader>tb',
        function()
          require('telescope.builtin').buffers({
            sort_mru = true,
            ignore_current_buffer = true,
            previewer = false,
            show_all_buffers = true,
          })
        end,
        desc = 'Buffers',
      },
      {
        '<leader>tS',
        function()
          require('telescope.builtin').live_grep({
            cwd = vim.fn.getcwd(),
            additional_args = function()
              return { '--hidden', '--glob', '!.git/*' }
            end,
          })
        end,
        desc = 'Live grep (cwd)',
      },
      {
        '<leader>tF',
        function()
          require('telescope.builtin').find_files({
            cwd = vim.fn.getcwd(),
            hidden = true,
            follow = true,
          })
        end,
        desc = 'Find files (cwd)',
      },
      {
        '<leader>tG',
        function()
          require('telescope').extensions.live_grep_args.live_grep_args()
        end,
        desc = 'Live grep (args)',
      },
    },
  },

  -- ===== AI-first editor stack =====

  { -- Claude Code IDE integration: Claude reads selection, opens diffs, applies edits
    'coder/claudecode.nvim',
    config = true,
    cmd = {
      'ClaudeCode',
      'ClaudeCodeFocus',
      'ClaudeCodeAdd',
      'ClaudeCodeSend',
      'ClaudeCodeTreeAdd',
      'ClaudeCodeDiffAccept',
      'ClaudeCodeDiffDeny',
    },
    keys = {
      { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Claude Code: toggle' },
      { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Claude Code: focus' },
      { '<leader>cr', '<cmd>ClaudeCode --resume<cr>', desc = 'Claude Code: resume' },
      { '<leader>cR', '<cmd>ClaudeCode --continue<cr>', desc = 'Claude Code: continue last' },
      { '<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Claude Code: add current buffer' },
      { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Claude Code: send selection' },
      { '<leader>cda', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Claude Code: accept diff' },
      { '<leader>cdd', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Claude Code: deny diff' },
    },
  },

  { -- CodeCompanion: API-direct chat + inline edits with first-class Anthropic adapter
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions', 'CodeCompanionCmd' },
    opts = {
      strategies = {
        chat = { adapter = 'anthropic' },
        inline = { adapter = 'anthropic' },
        cmd = { adapter = 'anthropic' },
      },
      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            schema = {
              model = { default = 'claude-opus-4-7' },
            },
          })
        end,
      },
      display = {
        chat = {
          show_settings = true,
          window = { position = 'right', width = 0.4 },
        },
      },
    },
    keys = {
      { '<leader>mc', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion: chat toggle' },
      { '<leader>ma', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion: actions' },
      { '<leader>me', ':CodeCompanion ', mode = { 'n', 'v' }, desc = 'CodeCompanion: inline edit' },
      { 'ga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'CodeCompanion: add selection to chat' },
    },
  },

  { -- Render markdown / AI chat buffers with proper styling
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion', 'Avante', 'copilot-chat' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      file_types = { 'markdown', 'codecompanion' },
      render_modes = true,
      anti_conceal = { enabled = false },
      -- Keep the cursor line rendered (default '' reveals raw text on the cursor line)
      win_options = { concealcursor = { rendered = 'nvic' } },
      -- Wrapped (virtual-line) tables are always un-rendered on the cursor row
      pipe_table = { wrap = false },
      heading = { sign = false },
      -- border = 'hide' conceals the closing fence line, which also hides the
      -- ascii-mermaid diagram attached to it (inline virt_lines). Keep it visible.
      code = { sign = false, width = 'block', right_pad = 1, border = 'thin' },
      checkbox = { enabled = true },
    },
  },

  { -- Multi-file diff review for AI's agentic edits
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewFileHistory',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewRefresh',
    },
    keys = {
      { '<leader>dv', '<cmd>DiffviewOpen<cr>', desc = 'Diffview: open (working tree)' },
      { '<leader>dh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview: file history' },
      { '<leader>dH', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview: repo history' },
      { '<leader>dx', '<cmd>DiffviewClose<cr>', desc = 'Diffview: close' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = { layout = 'diff3_mixed' },
      },
    },
  },

  { -- Resolve merge conflicts produced by agent edits
    'akinsho/git-conflict.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      default_mappings = true,
      default_commands = true,
      list_opener = 'copen',
    },
  },

  { -- Tag anchor files so AI plugins can grab them by name
    'cbochs/grapple.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Grapple',
    opts = {
      scope = 'git',
    },
    keys = {
      { '<leader>gM', '<cmd>Grapple toggle<cr>', desc = 'Grapple: tag/untag file' },
      { '<leader>gm', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple: list tags' },
      { '<leader>gn', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple: next tag' },
      { '<leader>gp', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple: previous tag' },
    },
  },

  { -- Prettier vim.ui.input / vim.ui.select used by AI plugin prompts
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },
}
