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
      "comment",
      "go",
      "json",
      "make",
      "rust",
      "yaml",
      "python",
      "hcl",
  },
  rainbow = {
      enable = true,
      extended_mode = true,
  }
})
