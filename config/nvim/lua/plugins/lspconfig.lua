lspconfig = require "lspconfig"
lspcontainers = require "lspcontainers"

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require("lsp_signature").on_attach({
      bind = true,
      floating_window = false,
      hint_enable = true,
  })

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          fieldalignment = true,
          nilness = true,
        },
        staticcheck = true,
        gofumpt = true,
        buildFlags = { "-tags=tests,e2e,integration" },
        env = { GOFLAGS="-tags=tests,e2e,integration" },
      },
    },
}

lspconfig.jsonls.setup {
    before_init = function(params)
        params.processId = vim.NIL
    end,
    cmd = lspcontainers.command('jsonls', { container_runtime = "podman", network = "bridge", }),
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.yamlls.setup {
    before_init = function(params)
        params.processId = vim.NIL
    end,
    cmd = lspcontainers.command('yamlls', { container_runtime = "podman", network = "bridge", }),
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
        yaml = {
            format = {
                enable = true,
                printWidth = 120,
            },
        },
    },
}

lspconfig.terraformls.setup {
    before_init = function(params)
        params.processId = vim.NIL
    end,
    cmd = lspcontainers.command('terraformls', { container_runtime = "podman", network = "bridge", }),
    filetypes = { "hcl", "tf", "terraform", "tfvars" },
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.pyright.setup {
    before_init = function(params)
      params.processId = vim.NIL
    end,
    cmd = lspcontainers.command('pyright', { container_runtime = "podman", }),
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                runBuildScripts = true,
            },
            checkOnSave = {
                command = "clippy"
            },
        },
    },
}



-- Set completeopt to have a better completion experience
--vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local signs = {
    Error = " " ,
    Warn = " ",
    Hint = " ",
    Info = "💡"
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
