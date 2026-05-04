local bufnr = vim.api.nvim_get_current_buf()
local ok = pcall(vim.treesitter.start, bufnr, 'markdown')
if not ok then
  pcall(vim.treesitter.stop, bufnr)
end
