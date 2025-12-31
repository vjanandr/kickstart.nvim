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
  -- GitHub integration for code reviews
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup {
        default_remote = { 'upstream', 'origin' }, -- order to try remotes
        ssh_aliases = {}, -- SSH aliases. e.g. { "github.com", "github.com" }
        reaction_viewer_hint_icon = '', -- marker for user reactions
        user_icon = ' ', -- user icon
        timeline_marker = '', -- timeline marker
        timeline_indent = 2, -- timeline indentation
        right_bubble_delimiter = '', -- bubble delimiter
        left_bubble_delimiter = '', -- bubble delimiter
        github_hostname = '', -- GitHub Enterprise host
        snippet_context_lines = 4, -- number or lines around commented lines
        gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
        timeout = 5000, -- timeout for requests between the remote server
        ui = {
          use_signcolumn = true, -- show "modified" marks on the sign column
        },
        issues = {
          order_by = { -- criteria to sort results of `Octo issue list`
            field = 'CREATED_AT', -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = 'DESC', -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          },
        },
        pull_requests = {
          order_by = { -- criteria to sort the results of `Octo pr list`
            field = 'CREATED_AT', -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = 'DESC', -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          },
          always_select_remote_on_create = false, -- always give prompt to select base remote repo when creating PRs
        },
        file_panel = {
          size = 10, -- changed files panel rows
          use_icons = true, -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
        },
        mappings = {
          issue = {
            close_issue = { lhs = '<space>ic', desc = 'close issue' },
            reopen_issue = { lhs = '<space>io', desc = 'reopen issue' },
            list_issues = { lhs = '<space>il', desc = 'list open issues on same repo' },
            reload = { lhs = '<C-r>', desc = 'reload issue' },
            open_in_browser = { lhs = '<C-b>', desc = 'open issue in browser' },
            copy_url = { lhs = '<C-y>', desc = 'copy url to system clipboard' },
            add_assignee = { lhs = '<space>aa', desc = 'add assignee' },
            remove_assignee = { lhs = '<space>ad', desc = 'remove assignee' },
            create_label = { lhs = '<space>lc', desc = 'create label' },
            add_label = { lhs = '<space>la', desc = 'add label' },
            remove_label = { lhs = '<space>ld', desc = 'remove label' },
            goto_issue = { lhs = '<space>gi', desc = 'navigate to a local repo issue' },
            add_comment = { lhs = '<space>ca', desc = 'add comment' },
            delete_comment = { lhs = '<space>cd', desc = 'delete comment' },
            next_comment = { lhs = ']c', desc = 'go to next comment' },
            prev_comment = { lhs = '[c', desc = 'go to previous comment' },
            react_hooray = { lhs = '<space>rp', desc = 'add/remove 🎉 reaction' },
            react_heart = { lhs = '<space>rh', desc = 'add/remove ❤️ reaction' },
            react_eyes = { lhs = '<space>re', desc = 'add/remove 👀 reaction' },
            react_thumbs_up = { lhs = '<space>ru', desc = 'add/remove 👍 reaction' },
            react_thumbs_down = { lhs = '<space>rd', desc = 'add/remove 👎 reaction' },
            react_rocket = { lhs = '<space>rr', desc = 'add/remove 🚀 reaction' },
            react_laugh = { lhs = '<space>rl', desc = 'add/remove 😄 reaction' },
            react_confused = { lhs = '<space>rc', desc = 'add/remove 😕 reaction' },
          },
          pull_request = {
            checkout_pr = { lhs = '<space>po', desc = 'checkout PR' },
            merge_pr = { lhs = '<space>pm', desc = 'merge commit PR' },
            squash_and_merge_pr = { lhs = '<space>psm', desc = 'squash and merge PR' },
            list_commits = { lhs = '<space>pc', desc = 'list PR commits' },
            list_changed_files = { lhs = '<space>pf', desc = 'list PR changed files' },
            show_pr_diff = { lhs = '<space>pd', desc = 'show PR diff' },
            add_reviewer = { lhs = '<space>va', desc = 'add reviewer' },
            remove_reviewer = { lhs = '<space>vd', desc = 'remove reviewer request' },
            close_issue = { lhs = '<space>ic', desc = 'close PR' },
            reopen_issue = { lhs = '<space>io', desc = 'reopen PR' },
            list_issues = { lhs = '<space>il', desc = 'list open issues on same repo' },
            reload = { lhs = '<C-r>', desc = 'reload PR' },
            open_in_browser = { lhs = '<C-b>', desc = 'open PR in browser' },
            copy_url = { lhs = '<C-y>', desc = 'copy url to system clipboard' },
            goto_file = { lhs = 'gf', desc = 'go to file' },
            add_assignee = { lhs = '<space>aa', desc = 'add assignee' },
            remove_assignee = { lhs = '<space>ad', desc = 'remove assignee' },
            create_label = { lhs = '<space>lc', desc = 'create label' },
            add_label = { lhs = '<space>la', desc = 'add label' },
            remove_label = { lhs = '<space>ld', desc = 'remove label' },
            goto_issue = { lhs = '<space>gi', desc = 'navigate to a local repo issue' },
            add_comment = { lhs = '<space>ca', desc = 'add comment' },
            delete_comment = { lhs = '<space>cd', desc = 'delete comment' },
            next_comment = { lhs = ']c', desc = 'go to next comment' },
            prev_comment = { lhs = '[c', desc = 'go to previous comment' },
            react_hooray = { lhs = '<space>rp', desc = 'add/remove 🎉 reaction' },
            react_heart = { lhs = '<space>rh', desc = 'add/remove ❤️ reaction' },
            react_eyes = { lhs = '<space>re', desc = 'add/remove 👀 reaction' },
            react_thumbs_up = { lhs = '<space>ru', desc = 'add/remove 👍 reaction' },
            react_thumbs_down = { lhs = '<space>rd', desc = 'add/remove 👎 reaction' },
            react_rocket = { lhs = '<space>rr', desc = 'add/remove 🚀 reaction' },
            react_laugh = { lhs = '<space>rl', desc = 'add/remove 😄 reaction' },
            react_confused = { lhs = '<space>rc', desc = 'add/remove 😕 reaction' },
          },
          review_thread = {
            goto_issue = { lhs = '<space>gi', desc = 'navigate to a local repo issue' },
            add_comment = { lhs = '<space>rc', desc = 'add comment' },
            add_suggestion = { lhs = '<space>sa', desc = 'add suggestion' },
            delete_comment = { lhs = '<space>cd', desc = 'delete comment' },
            next_comment = { lhs = ']c', desc = 'go to next comment' },
            prev_comment = { lhs = '[c', desc = 'go to previous comment' },
            select_next_entry = { lhs = ']q', desc = 'move to next changed file' },
            select_prev_entry = { lhs = '[q', desc = 'move to previous changed file' },
            select_first_entry = { lhs = '[Q', desc = 'move to first changed file' },
            select_last_entry = { lhs = ']Q', desc = 'move to last changed file' },
            close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
            react_hooray = { lhs = '<space>rp', desc = 'add/remove 🎉 reaction' },
            react_heart = { lhs = '<space>rh', desc = 'add/remove ❤️ reaction' },
            react_eyes = { lhs = '<space>re', desc = 'add/remove 👀 reaction' },
            react_thumbs_up = { lhs = '<space>ru', desc = 'add/remove 👍 reaction' },
            react_thumbs_down = { lhs = '<space>rd', desc = 'add/remove 👎 reaction' },
            react_rocket = { lhs = '<space>rr', desc = 'add/remove 🚀 reaction' },
            react_laugh = { lhs = '<space>rl', desc = 'add/remove 😄 reaction' },
            react_confused = { lhs = '<space>rc', desc = 'add/remove 😕 reaction' },
          },
          submit_win = {
            approve_review = { lhs = '<C-a>', desc = 'approve review' },
            comment_review = { lhs = '<C-m>', desc = 'comment review' },
            request_changes = { lhs = '<C-r>', desc = 'request changes review' },
            close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
          },
          review_diff = {
            add_review_comment = { lhs = '<space>rc', desc = 'add a new review comment' },
            add_review_suggestion = { lhs = '<space>sa', desc = 'add a new review suggestion' },
            focus_files = { lhs = '<leader>e', desc = 'move focus to changed file panel' },
            toggle_files = { lhs = '<leader>b', desc = 'hide/show changed files panel' },
            next_thread = { lhs = ']t', desc = 'move to next thread' },
            prev_thread = { lhs = '[t', desc = 'move to previous thread' },
            select_next_entry = { lhs = ']q', desc = 'move to next changed file' },
            select_prev_entry = { lhs = '[q', desc = 'move to previous changed file' },
            select_first_entry = { lhs = '[Q', desc = 'move to first changed file' },
            select_last_entry = { lhs = ']Q', desc = 'move to last changed file' },
            close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
            toggle_viewed = { lhs = '<leader><space>', desc = 'toggle viewer viewed state' },
          },
          file_panel = {
            next_entry = { lhs = 'j', desc = 'move to next changed file' },
            prev_entry = { lhs = 'k', desc = 'move to previous changed file' },
            select_entry = { lhs = '<cr>', desc = 'show selected changed file diffs' },
            refresh_files = { lhs = 'R', desc = 'refresh changed files panel' },
            focus_files = { lhs = '<leader>e', desc = 'move focus to changed file panel' },
            toggle_files = { lhs = '<leader>b', desc = 'hide/show changed files panel' },
            select_next_entry = { lhs = ']q', desc = 'move to next changed file' },
            select_prev_entry = { lhs = '[q', desc = 'move to previous changed file' },
            select_first_entry = { lhs = '[Q', desc = 'move to first changed file' },
            select_last_entry = { lhs = ']Q', desc = 'move to last changed file' },
            close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
            toggle_viewed = { lhs = '<leader><space>', desc = 'toggle viewer viewed state' },
          },
        },
      }
      vim.cmd [[hi OctoEditable guibg=none]]
    end,
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
  {
    'dkarter/bullets.vim',
    ft = { 'markdown', 'text' },
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
    ft = { 'markdown', 'rst', 'org', 'text' },
    init = function()
      vim.g.table_mode_auto_align = 1
    end,
    keys = {
      { '<leader>t[', '<Plug>(table-mode-insert-column-before)', mode = 'n', desc = 'Table: insert column before' },
      { '<leader>t]', '<Plug>(table-mode-insert-column-after)', mode = 'n', desc = 'Table: insert column after' },
      { '<leader>t-', '<Plug>(table-mode-insert-row-before)', mode = 'n', desc = 'Table: insert row above' },
      { '<leader>t=', '<Plug>(table-mode-insert-row-after)', mode = 'n', desc = 'Table: insert row below' },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
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
    },
  },
}