return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        cmd = {
          adapter = "ollama",
          model = "qwen3-coder-next",
        },
        chat = {
          adapter = "ollama",
          model = "qwen3-coder-next",
        },
        inline = {
          adapter = "ollama",
          model = "qwen3-coder-next",
        },
      },
      opts = {
        log_level = "INFO", -- or "TRACE"
      },
    },
  },
}
