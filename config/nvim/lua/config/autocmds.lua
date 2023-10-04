-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_cell_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("spell_lang"),
  pattern = { "asciidoc", "gitcommit", "go", "markdown", "md", "rst", "rust", "tex", "text" },
  callback = function()
    vim.opt_local.spelllang = "en_gb"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("trim_trailing_ws"),
  callback = function()
    if not vim.o.binary and vim.o.filetype ~= "diff" then
      local current_view = vim.fn.winsaveview()
      vim.cmd([[keeppatterns %s/\s\+$//e]])
      vim.fn.winrestview(current_view)
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open Neotree automatically",
  group = augroup("neotree"),
  callback = function()
    vim.cmd("Neotree show")
    -- vim.cmd("wincmd p")
  end,
})
