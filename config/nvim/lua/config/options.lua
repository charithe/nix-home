-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true

local opt = vim.opt

opt.autoindent = true
opt.autoread = true
opt.backspace = "indent,eol,start"
opt.backupdir = vim.fn.stdpath("data") .. "/backup"
opt.colorcolumn = "120"
opt.directory = vim.fn.stdpath("data") .. "/swap"
opt.encoding = "utf-8"
opt.expandtab = true
opt.laststatus = 3
opt.linebreak = true
opt.list = false
opt.listchars =
  { tab = "→ ", space = "⋅", eol = "↲", nbsp = "␣", trail = "•", extends = "❯", precedes = "❮" }
opt.modeline = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = false
opt.ruler = true
opt.scrolloff = 3
opt.signcolumn = "yes"
opt.shiftwidth = 4
opt.showbreak = "↪ "
opt.softtabstop = 4
opt.spelloptions = "camel"
opt.splitkeep = "screen"
opt.tabstop = 4
opt.ttyfast = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.wrap = true
opt.whichwrap = "<,>,h,l"

vim.o.t_TI = "^[[4?h"
vim.o.t_TE = "^[[4?l"
