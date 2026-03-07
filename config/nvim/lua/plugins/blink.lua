return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "moyiz/blink-emoji.nvim",
    },
    opts = {
      sources = {
        default = {
          "emoji",
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
          },
          path = {
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },
        },
      },
    },
  },
}
