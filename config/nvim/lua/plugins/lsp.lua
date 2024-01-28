return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<CR>" }
      keys[#keys + 1] = { "<leader>gi", "<cmd>Lspsaga incoming_calls<CR>" }
      keys[#keys + 1] = { "<leader>go", "<cmd>Lspsaga outgoing_calls<CR>" }
      keys[#keys + 1] = { "<leader>gf", "<cmd>Lspsaga finder<CR>" }
      keys[#keys + 1] = { "<leader>gd", "<cmd>Lspsaga peek_definition<CR>" }
      keys[#keys + 1] = { "<leader>gt", "<cmd>Lspsaga peek_type_definition<CR>" }
      keys[#keys + 1] = { "<leader>gs", "<cmd>Lspsaga outline<CR>" }
    end,
    opts = {
      servers = {
        bufls = {},
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
        tsserver = {},
        yamlls = {},
        zls = {},
      },
    },
  },
}
