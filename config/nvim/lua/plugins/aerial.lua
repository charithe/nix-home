return {
  {
    "stevearc/aerial.nvim",
    opts = {
      attach_mode = "global",
      open_automatic = true,
      show_guides = true,
      close_automatic_events = { "unsupported" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
