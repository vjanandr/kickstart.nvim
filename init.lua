--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Speed up Lua module loading (Neovim 0.9+)
pcall(function()
  if vim.loader and vim.loader.enable then
    vim.loader.enable()
  end
end)

-- Enable syntax highlighting
vim.cmd 'syntax on'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Disable unused language providers to reduce startup work
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Improve UI responsiveness in remote/tmux sessions
vim.o.lazyredraw = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
-- vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = ''

vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.opt.guifont = '7x14'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  local function has_copier()
    return vim.fn.executable('xclip') == 1
      or vim.fn.executable('xsel') == 1
      or vim.fn.executable('wl-copy') == 1
      or vim.fn.executable('pbcopy') == 1
      or (vim.env.TMUX and vim.env.TMUX ~= '')
  end
  if vim.fn.has('clipboard') == 1 and has_copier() then
    vim.o.clipboard = 'unnamedplus'
  end
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Use spaces instead of tabs
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
-- Limit syntax highlighting on very long lines for performance
vim.o.synmaxcol = 240
vim.o.softtabstop = 2

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
-- vim.o.list = true
vim.opt.listchars = { tab = '>-', trail = '.', nbsp = '~' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Alternative: Use Telescope for fuzzy function finding
vim.keymap.set('n', '<leader>tf', ':Telescope treesitter<CR>', { desc = 'Find functions with Telescope' })

vim.keymap.set('n', '<leader>nt', '<cmd>TableModeToggle<CR>', { desc = 'Notes: table mode' })

-- Smarter gf: if under cursor is "filename:line[:col]", use gF to jump to that location
vim.keymap.set('n', 'gf', function()
  local cw = vim.fn.expand('<cWORD>')
  if type(cw) == 'string' and cw:match(':%d+') then
    vim.cmd('normal! gF')
  else
    vim.cmd('normal! gf')
  end
end, { desc = 'Open file under cursor (supports file:line[:col])' })

vim.api.nvim_create_user_command('E', function(opts)
  local arg = opts.args or ''
  local fname, lnum, col
  local m1, m2, m3 = string.match(arg, '^(.-):(%d+):(%d+)$')
  if m1 then
    fname, lnum, col = m1, tonumber(m2), tonumber(m3)
  else
    local n1, n2 = string.match(arg, '^(.-):(%d+)$')
    if n1 then
      fname, lnum = n1, tonumber(n2)
    else
      fname = arg
    end
  end
  vim.cmd('edit ' .. vim.fn.fnameescape(fname))
  if lnum then
    local c = (col and col > 0) and (col - 1) or 0
    pcall(vim.api.nvim_win_set_cursor, 0, { lnum, c })
  end
end, { nargs = 1, complete = 'file' })

-- Make :e and :edit accept filename:line[:col] transparently by routing to :E
vim.cmd [[
  cnoreabbrev <expr> e getcmdline() =~# '^e\s\+\S\+:\d\+\%(:\d\+\)\?\s*$' ? 'E' : 'e'
  cnoreabbrev <expr> edit getcmdline() =~# '^edit\s\+\S\+:\d\+\%(:\d\+\)\?\s*$' ? 'E' : 'edit'
]]

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local notes_au = vim.api.nvim_create_augroup('notes', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = notes_au,
  pattern = { 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.spell = false
    vim.opt_local.conceallevel = 2
    vim.opt_local.colorcolumn = ''
  end,
})

-- Open files passed as filename:line[:col] from the shell (e.g. `nvim foo.c:123:9`)
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    local argv = vim.fn.argv()
    if type(argv) ~= 'table' or #argv == 0 then
      return
    end
    local function open_at_pos(spec)
      local fname, lnum, col
      local m1, m2, m3 = string.match(spec, '^(.-):(%d+):(%d+)$')
      if m1 then
        fname, lnum, col = m1, tonumber(m2), tonumber(m3)
      else
        local n1, n2 = string.match(spec, '^(.-):(%d+)$')
        if n1 then
          fname, lnum = n1, tonumber(n2)
        else
          return false
        end
      end
      local uv = (vim.uv or vim.loop)
      local exists = (vim.fn.filereadable(fname) == 1) or (uv.fs_stat(fname) ~= nil)
      if not exists then
        return false
      end
      vim.cmd('silent edit ' .. vim.fn.fnameescape(fname))
      if lnum then
        local c = (col and col > 0) and (col - 1) or 0
        pcall(vim.api.nvim_win_set_cursor, 0, { lnum, c })
      end
      return true
    end
    for _, a in ipairs(argv) do
      if type(a) == 'string' and a:match(':%d+') then
        if open_at_pos(a) then
          break
        end
      end
    end
  end,
})

local lastplace = vim.api.nvim_create_augroup('kickstart-lastplace', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
  group = lastplace,
  callback = function(args)
    local bufnr = args.buf
    if vim.bo[bufnr].buftype ~= '' then
      return
    end
    local ft = vim.bo[bufnr].filetype
    if ft == 'gitcommit' or ft == 'gitrebase' then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(bufnr, '"')
    local lcount = vim.api.nvim_buf_line_count(bufnr)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, { mark[1], mark[2] })
    end
  end,
})

vim.cmd [[
  augroup BlackBackground
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=#000000
    autocmd ColorScheme * highlight NonText guifg=#666666 guibg=#000000
    autocmd ColorScheme * highlight LineNr guibg=#000000
    autocmd ColorScheme * highlight Folded guibg=#000000
  augroup END
]]

-- Override bold white text to be non-bold
vim.cmd [[
  augroup NoBoldWhite
    autocmd!
    autocmd ColorScheme * highlight Comment gui=NONE
    autocmd ColorScheme * highlight String gui=NONE
    autocmd ColorScheme * highlight Constant gui=NONE
    autocmd ColorScheme * highlight Identifier gui=NONE
    autocmd ColorScheme * highlight Statement gui=NONE
    autocmd ColorScheme * highlight Type gui=NONE
    autocmd ColorScheme * highlight Special gui=NONE
    autocmd ColorScheme * highlight PreProc gui=NONE
    autocmd ColorScheme * highlight SpecialKey guifg=#666666 gui=NONE
  augroup END
]]

-- Set strings to green color (non-bold)
vim.cmd [[
  augroup GreenStrings
    autocmd!
    autocmd ColorScheme * highlight String guifg=#4CE17C gui=NONE
  augroup END
]]

local grp = vim.api.nvim_create_augroup('C_Col81_PerLine', { clear = true })

-- Bright red bg for the single char at col 81
vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
  group = grp,
  callback = function()
    vim.api.nvim_set_hl(0, 'Col81Char', { bg = '#ff0000', ctermbg = 9 })
  end,
})

-- Apply only for C buffers; matches are dynamic (auto-update as you type)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'c',
  group = grp,
  callback = function()
    -- Remove any previous vertical-bar style matches if you tried them
    for _, m in ipairs(vim.fn.getmatches()) do
      if m.group == 'Col81Char' then
        vim.fn.matchdelete(m.id)
      end
    end
    -- Highlight **the character at virtual column 81** (not the whole column)
    -- This only shows on lines that *have* a char at col 81.
    vim.fn.matchadd('Col81Char', '\\%81v.', 200)
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  { 'NMAC427/guess-indent.nvim', event = { 'BufReadPre', 'BufNewFile' } },
  

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
      { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
      { '<leader>ss', '<cmd>Telescope builtin<cr>', desc = '[S]earch [S]elect Telescope' },
      { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord' },
      { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[S]earch by [G]rep' },
      { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', '<cmd>Telescope resume<cr>', desc = '[S]earch [R]esume' },
      { '<leader>s.', '<cmd>Telescope oldfiles<cr>', desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader><leader>', '<cmd>Telescope buffers<cr>', desc = '[ ] Find existing buffers' },
      { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find theme=dropdown previewer=false winblend=10<cr>', desc = '[/] Fuzzily search in current buffer' },
      {
        '<leader>s/',
        function()
          require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        desc = '[S]earch [/] in Open Files',
      },
      {
        '<leader>sn',
        function()
          require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[S]earch [N]eovim files',
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters = {
        clang_format = {
          command = (function()
            local mason_clang_format = vim.fn.stdpath('data') .. '/mason/bin/clang-format'
            local uv = (vim.uv or vim.loop)
            local real = uv.fs_realpath(mason_clang_format)
            if real then
              local stat = uv.fs_stat(real)
              if stat and vim.fn.executable(real) == 1 then
                return real
              end
            end
            return 'clang-format'
          end)(),
          prepend_args = {
            "--style={BasedOnStyle: LLVM, BreakBeforeBraces: Custom, BraceWrapping: {AfterFunction: true, AfterControlStatement: Never}}",
          },
        },
      },
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
    config = function(_, opts)
      local conform = require 'conform'
      conform.setup(opts)
      -- Disable autoformat on save by default (can be toggled globally or per-buffer)
      vim.g.disable_autoformat = true

      local group = vim.api.nvim_create_augroup('ConformFormatGitHunks', { clear = true })
      local uv = (vim.uv or vim.loop)
      local clang_format_available = nil

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        callback = function(args)
          local bufnr = args.buf
          local disable_filetypes = {}
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          if vim.bo[bufnr].buftype ~= '' or not vim.bo[bufnr].modifiable then
            return
          end

          local line_count_buf = vim.api.nvim_buf_line_count(bufnr)
          if line_count_buf > 5000 then
            return
          end

          local ft = vim.bo[bufnr].filetype
          local use_clang_format_only = (ft == 'c' or ft == 'cpp')

          if use_clang_format_only then
            if clang_format_available == nil then
              clang_format_available = (vim.fn.executable 'clang-format') == 1
            end
            if not clang_format_available then
              return
            end
          end

          local gitsigns = package.loaded.gitsigns
          if not gitsigns or type(gitsigns.get_hunks) ~= 'function' then
            return
          end

          local hunks = gitsigns.get_hunks(bufnr)
          if not hunks or vim.tbl_isempty(hunks) then
            return
          end

          local ranges = {}
          for _, hunk in ipairs(hunks) do
            local start_line = hunk.added and hunk.added.start or nil
            local count = hunk.added and hunk.added.count or nil
            if start_line and count and count > 0 then
              local s = start_line
              local e = start_line + count - 1
              ranges[#ranges + 1] = { s = s, e = e }
            end
          end

          if vim.tbl_isempty(ranges) then
            return
          end

          table.sort(ranges, function(a, b)
            return a.s < b.s
          end)

          local merged = { ranges[1] }
          for i = 2, #ranges do
            local last = merged[#merged]
            local cur = ranges[i]
            if cur.s <= (last.e + 1) then
              last.e = math.max(last.e, cur.e)
            else
              merged[#merged + 1] = cur
            end
          end

          for _, r in ipairs(merged) do
            conform.format {
              bufnr = bufnr,
              async = false,
              timeout_ms = 500,
              lsp_format = use_clang_format_only and 'never' or 'fallback',
              formatters = use_clang_format_only and { 'clang_format' } or nil,
              range = {
                start = { r.s - 1, 0 },
                ['end'] = { r.e, 0 },
              },
            }
          end
        end,
      })

      vim.api.nvim_create_user_command('AutoFormatToggle', function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      end, { desc = 'Toggle autoformat on save for current buffer' })
      pcall(vim.api.nvim_create_user_command, 'AutoFormatGlobalToggle', function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end, { desc = 'Toggle autoformat on save globally' })
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = true,
  },
  {
    'projekt0n/github-nvim-theme',
    lazy = true, -- loaded by the colorscheme command below
  },

  {
    'rebelot/kanagawa.nvim',
    config = function()
      vim.cmd.colorscheme 'github_dark_colorblind'
      vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#2d3748', fg = '#ffffff', bold = true })
      vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = '#ff6b6b' })
      vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#ffd93d', bold = true })
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#4a5568' })
      vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#c0c0c0', bg = '#333333' }) -- light fg, dark bg
      vim.api.nvim_set_hl(0, 'NonText', { fg = '#c0c0c0', bg = '#333333' })
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
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VeryLazy', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Automatic bullet and numbering for lists
  { 'dkarter/bullets.vim' },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      local function autoformat_status()
        if vim.g.disable_autoformat or vim.b.disable_autoformat then
          return 'AF:OFF'
        end
        return 'AF:ON'
      end

      local function tablemode_status()
        if vim.fn.exists('*tablemode#IsActive') == 1 then
          local ok, res = pcall(function()
            return vim.fn['tablemode#IsActive']()
          end)
          if ok and res == 1 then
            return 'TBL:ON'
          else
            return 'TBL:OFF'
          end
        end
        if vim.b.table_mode_active == 1 or vim.g.table_mode_active == 1 then
          return 'TBL:ON'
        end
        return 'TBL:OFF'
      end

      local section_fileinfo = statusline.section_fileinfo
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_fileinfo = function(...)
        return autoformat_status() .. ' ' .. tablemode_status() .. ' ' .. section_fileinfo(...)
      end

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Large-file guard: disable nonessential visuals for huge files
      do
        local grp = vim.api.nvim_create_augroup('kickstart-large-file-guard', { clear = true })
        local uv = (vim.uv or vim.loop)
        local function is_large(buf)
          local name = vim.api.nvim_buf_get_name(buf)
          if name == '' then return false end
          local ok, st = pcall(uv.fs_stat, name)
          if ok and st and st.size and st.size > 500 * 1024 then -- >500KB
            return true
          end
          local lc = vim.api.nvim_buf_line_count(buf)
          return lc > 100000 -- >100k lines
        end
        local function disable_visuals()
          pcall(function()
            local ok_hl, hlslens = pcall(require, 'hlslens')
            if ok_hl and hlslens and type(hlslens.stop) == 'function' then hlslens.stop() end
          end)
        end
        vim.api.nvim_create_autocmd('BufReadPost', {
          group = grp,
          callback = function(args)
            local buf = args.buf
            vim.b[buf].large_file_mode = is_large(buf) and true or false
            if vim.b[buf].large_file_mode then
              disable_visuals()
            end
          end,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'WinScrolled', 'CmdlineLeave', 'InsertEnter' }, {
          group = grp,
          callback = function(args)
            if vim.b[args.buf].large_file_mode then
              disable_visuals()
            end
          end,
        })
        vim.api.nvim_create_user_command('LargeFileVisualsToggle', function()
          local buf = vim.api.nvim_get_current_buf()
          vim.b[buf].large_file_mode = not vim.b[buf].large_file_mode
          if vim.b[buf].large_file_mode then
            disable_visuals()
            vim.notify('Large-file visuals: OFF for this buffer')
          else
            vim.notify('Large-file visuals: ON for this buffer')
          end
        end, { desc = 'Toggle large-file visual guard for current buffer' })
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    -- Using the stable 'master' branch for compatibility
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = {
          'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc',
          'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'rust', 'toml', 'yaml'
        },
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(_, buf)
            local name = vim.api.nvim_buf_get_name(buf)
            local ok, st = pcall(vim.uv.fs_stat, name)
            if ok and st and st.size and st.size > 200 * 1024 then
              return true
            end
            local lc = vim.api.nvim_buf_line_count(buf)
            return lc > 5000
          end,
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = {
          enable = true,
          disable = function(lang, buf)
            if lang == 'ruby' then
              return true
            end
            return vim.api.nvim_buf_line_count(buf) > 5000
          end,
        },
      })

      -- Patch nvim-treesitter master directives broken on nvim 0.12.
      -- In 0.12, query match[capture_id] returns a *list* of nodes, not a
      -- single node. nvim-treesitter master hasn't migrated, so calls like
      -- vim.treesitter.get_node_text(match[id], buf) fail with
      -- "attempt to call method 'range' (a nil value)".
      local tsq = vim.treesitter.query
      local html_script_type_languages = {
        importmap = 'json',
        module = 'javascript',
        ['application/ecmascript'] = 'javascript',
        ['text/ecmascript'] = 'javascript',
      }
      local md_injection_aliases = {
        ex = 'elixir', pl = 'perl', sh = 'bash', uxn = 'uxntal', ts = 'typescript',
      }
      local function first_node(n)
        if type(n) == 'table' then return n[1] end
        return n
      end
      tsq.add_directive('set-lang-from-info-string!', function(match, _, bufnr, pred, metadata)
        local node = first_node(match[pred[2]])
        if not node then return end
        local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
        if not ok or not text then return end
        local alias = text:lower()
        local ftmatch = vim.filetype.match { filename = 'a.' .. alias }
        metadata['injection.language'] = ftmatch or md_injection_aliases[alias] or alias
      end, { force = true, all = false })
      tsq.add_directive('set-lang-from-mimetype!', function(match, _, bufnr, pred, metadata)
        local node = first_node(match[pred[2]])
        if not node then return end
        local ok, val = pcall(vim.treesitter.get_node_text, node, bufnr)
        if not ok or not val then return end
        local configured = html_script_type_languages[val]
        if configured then
          metadata['injection.language'] = configured
        else
          local parts = vim.split(val, '/', {})
          metadata['injection.language'] = parts[#parts]
        end
      end, { force = true, all = false })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ['rust-analyzer'] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = 'clippy' },
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>rr', '<cmd>RustLsp runnables<cr>', mode = 'n', desc = 'Rust: runnables' },
      { '<leader>re', '<cmd>RustLsp expandMacro<cr>', mode = 'n', desc = 'Rust: expand macro' },
      { '<leader>rx', '<cmd>RustLsp explainError<cr>', mode = 'n', desc = 'Rust: explain error' },
    },
  },
  {
    'saecki/crates.nvim',
    ft = { 'toml' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup {}
    end,
    keys = {
      { '<leader>cv', function() require('crates').show_versions_popup() end, mode = 'n', desc = 'Crates: versions' },
      { '<leader>cu', function() require('crates').upgrade_crate() end, mode = 'n', desc = 'Crates: upgrade' },
      { '<leader>cU', function() require('crates').upgrade_all_crates() end, mode = 'n', desc = 'Crates: upgrade all' },
    },
  },

  -- Markdown support plugins
  {
    'preservim/vim-markdown',
    ft = 'markdown',
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      vim.g.mkdp_browser = 'w3m'
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_port = '8080'
    end,
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'zipPlugin',
        'tutor',
        'vimball',
        'vimballPlugin',
        'spellfile_plugin',
        -- keep netrw enabled for remote workflows
      },
    },
  },
})

-- Lightweight, non-blocking cscope auto-add for C/C++ buffers
do
  local uv = (vim.uv or vim.loop)
  local added = {}
  local grp = vim.api.nvim_create_augroup('kickstart-cscope-auto', { clear = true })
  local function dirname(p)
    return vim.fn.fnamemodify(p, ':h')
  end
  local function realpath(p)
    return uv.fs_realpath(p) or p
  end
  local function find_cscope(start)
    local dir = realpath(dirname(start))
    local last = ''
    while dir and dir ~= last do
      local cand = dir .. '/cscope.out'
      local st = uv.fs_stat(cand)
      if st and st.type == 'file' then
        return cand
      end
      last = dir
      dir = dirname(dir)
    end
    return nil
  end
  vim.api.nvim_create_autocmd('BufEnter', {
    group = grp,
    pattern = { '*.c', '*.h', '*.cpp', '*.hpp', '*.cc', '*.hh' },
    callback = function(args)
      if vim.fn.executable('cscope') ~= 1 then
        return
      end
      local file = vim.api.nvim_buf_get_name(args.buf)
      if file == '' then
        return
      end
      local db = find_cscope(file)
      if not db then
        return
      end
      local key = realpath(db)
      if added[key] then
        return
      end
      pcall(vim.cmd, 'silent! cscope add ' .. vim.fn.fnameescape(db))
      added[key] = true
    end,
  })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
