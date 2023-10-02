require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
      enable = true,
  },
  incremental_selection = {
      enable = true,
  },
  ensure_installed = {
      "bash",
      "comment",
      "go",
      "hcl",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "tsx",
      "typescript",
      "vim",
      "yaml",
  },
  rainbow = {
      enable = true,
      extended_mode = true,
  }
})
