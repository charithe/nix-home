return {
  {
    "stevearc/aerial.nvim",
    enabled = false,
    opts = {
      attach_mode = "window",
      open_automatic = true,
      show_guides = true,
      close_automatic_events = { "unfocus", "unsupported" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
