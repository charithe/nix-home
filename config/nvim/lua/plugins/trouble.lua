return {
  {
    "folke/trouble.nvim",
    branch = "main",
    opts = {
      auto_open = true,
      auto_close = true,
      auto_preview = true,
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        virtual_lines = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      })
    end,
  },
}
