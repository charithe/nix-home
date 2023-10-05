return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bufls = {},
        gopls = {
          keys = {
            -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
            { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
            { "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
          },
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
              buildFlags = { "-tags=tests,e2e,integration" },
              env = { GOFLAGS = "-tags=tests,e2e,integration" },
              ["local"] = "github.com/cerbos",
            },
          },
        },
        helm_ls = {},
        jsonls = {},
        postgres_lsp = {},
        ruff_lsp = {},
        rust_analyzer = {},
        terraform_lsp = {},
        yamlls = {},
      },
    },
  },
}
