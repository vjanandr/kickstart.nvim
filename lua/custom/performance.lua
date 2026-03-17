-- Performance optimizations for Neovim
-- This module contains various performance tweaks to keep Neovim responsive

local M = {}

-- Optimize clangd for C/C++ development
function M.setup_clangd_optimizations()
  local lspconfig = require('lspconfig')
  
  -- Enhanced clangd configuration for performance
  lspconfig.clangd.setup{
    cmd = {
      "clangd",
      "--background-index",           -- Index in background for faster navigation
      "--clang-tidy",                  -- Enable clang-tidy diagnostics
      "--completion-style=detailed",   -- Detailed completion info
      "--header-insertion=iwyu",       -- Smart header insertion
      "--header-insertion-decorators", -- Show decorators for headers
      "--pch-storage=memory",          -- Store PCH in memory for speed
      "--j=4",                         -- Use 4 threads for indexing
      "--limit-results=50",            -- Limit results for responsiveness
      "--limit-references=100",        -- Limit references search
    },
    init_options = {
      clangdFileStatus = true,         -- Show file status
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
    -- Performance-focused capabilities
    capabilities = vim.tbl_deep_extend(
      'force',
      require('cmp_nvim_lsp').default_capabilities(),
      {
        -- Disable slow features for large files
        textDocument = {
          semanticTokens = {
            dynamicRegistration = false,
          },
        },
      }
    ),
  }
end

-- Optimize Telescope for faster file operations
function M.setup_telescope_optimizations()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  
  telescope.setup{
    defaults = {
      -- Performance optimizations
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
      },
      
      -- Faster file finding
      file_ignore_patterns = {
        "node_modules",
        "%.git/",
        "build/",
        "target/",
        "%.o$",
        "%.a$",
        "%.so$",
        "%.dylib$",
        "%.class$",
        "%.pdf$",
        "%.mkv$",
        "%.mp4$",
        "%.zip$",
      },
      
      -- Optimized settings
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',              -- Search hidden files
        '--glob=!.git/*',        -- Exclude .git
        '--glob=!build/*',       -- Exclude build dirs
        '--glob=!*.o',           -- Exclude object files
        '--glob=!*.a',           -- Exclude static libs
      },
      
      -- UI optimizations
      set_env = { ['COLORTERM'] = 'truecolor' },
      prompt_prefix = "🔍 ",
      selection_caret = "❯ ",
      path_display = { "truncate" },
      
      -- Mapping optimizations
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<Esc>"] = actions.close,
        },
      },
      
      -- Buffer settings
      cache_picker = {
        num_pickers = 10,
      },
    },
    
    pickers = {
      find_files = {
        hidden = true,
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--exclude", ".git" },
      },
      live_grep = {
        only_sort_text = true,  -- Faster sorting
      },
      buffers = {
        sort_mru = true,
        ignore_current_buffer = true,
      },
    },
    
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  }
  
  -- Load FZF extension for native speed
  pcall(telescope.load_extension, 'fzf')
end

-- Setup performance monitoring commands
function M.setup_performance_commands()
  -- Command to benchmark startup time
  vim.api.nvim_create_user_command('BenchmarkStartup', function()
    local tempfile = vim.fn.tempname()
    vim.fn.system(string.format('nvim --headless +quit --startuptime %s', tempfile))
    vim.cmd('edit ' .. tempfile)
    vim.cmd('normal! G')
    local last_line = vim.fn.getline('$')
    local time = last_line:match('%d+%.%d+')
    if time then
      vim.notify(string.format('Startup time: %sms', time), vim.log.levels.INFO)
    end
  end, { desc = 'Benchmark Neovim startup time' })
  
  -- Command to profile plugin loading
  vim.api.nvim_create_user_command('ProfilePlugins', function()
    vim.cmd('Lazy profile')
  end, { desc = 'Profile plugin loading times' })
  
  -- Command to check LSP performance
  vim.api.nvim_create_user_command('LSPPerformance', function()
    local clients = vim.lsp.get_clients()
    if #clients == 0 then
      vim.notify('No LSP clients attached', vim.log.levels.WARN)
      return
    end
    
    local info = {}
    for _, client in ipairs(clients) do
      table.insert(info, string.format('Client: %s (id: %d)', client.name, client.id))
    end
    vim.notify(table.concat(info, '\n'), vim.log.levels.INFO)
  end, { desc = 'Show LSP client performance info' })
end

-- Optimize diagnostic display for performance
function M.setup_diagnostic_optimizations()
  vim.diagnostic.config({
    update_in_insert = false,        -- Don't update diagnostics while typing
    severity_sort = true,
    virtual_text = {
      spacing = 4,
      prefix = '●',
      severity = {
        min = vim.diagnostic.severity.WARN,  -- Only show warnings and errors
      },
    },
    float = {
      source = 'if_many',
      border = 'rounded',
      focusable = false,
    },
    signs = true,
    underline = true,
  })
end

-- Setup all performance optimizations
function M.setup()
  M.setup_performance_commands()
  M.setup_diagnostic_optimizations()
  
  -- Defer heavy setup to after startup
  vim.defer_fn(function()
    -- Only setup if plugins are loaded
    if pcall(require, 'telescope') then
      M.setup_telescope_optimizations()
    end
  end, 100)
end

return M
