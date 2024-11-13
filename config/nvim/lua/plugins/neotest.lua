return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "fredrikaverpil/neotest-golang", version = "*" },
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          go_test_args = { "-tags=tests,integration" },
        },
      },
    },
  },
}
