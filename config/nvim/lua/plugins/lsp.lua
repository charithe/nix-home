return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover documentation" },
            { "<leader>gi", "<cmd>Lspsaga incoming_calls<CR>", desc = "Incoming calls" },
            { "<leader>go", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Outgoing calls" },
            { "<leader>gf", "<cmd>Lspsaga finder<CR>", desc = "Find occurrences" },
            { "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Go to definition" },
            { "<leader>gt", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Go to type definition" },
            { "<leader>gs", "<cmd>Lspsaga outline<CR>", desc = "Outline" },
          },
        },
        bacon_ls = {
          enabled = diagnostics == "bacon-ls",
        },
        bufls = {},
        gleam = {},
        gopls = {
          keys = {
            -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
            { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
            { "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
          },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          settings = {
            gopls = {
              gofumpt = true,
              templateExtensions = { "gotmpl" },
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
                assignVariableTypes = false,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = false,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = false,
                ignoredError = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = false,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
              buildFlags = { "-tags=tests,e2e,integration,oxi" },
              env = { GOFLAGS = "-tags=tests,e2e,integration,oxi" },
              ["local"] = "github.com/cerbos",
            },
          },
        },
        helm_ls = {},
        jsonls = {},
        postgres_lsp = {},
        ruff_lsp = {},
        terraform_lsp = {},
        tsserver = {},
        vale_ls = {},
        yamlls = {},
        zls = {},
      },
    },
  },
}
