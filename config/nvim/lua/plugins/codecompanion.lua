return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      interactions = {
        cmd = {
          adapter = "ollama",
          model = "qwen3-coder",
        },
        chat = {
          adapter = "ollama",
          model = "qwen3-coder",
        },
        inline = {
          adapter = "ollama",
          model = "qwen3-coder",
        },
      },
      opts = {
        log_level = "INFO", -- or "TRACE"
      },
    },
  },
}
