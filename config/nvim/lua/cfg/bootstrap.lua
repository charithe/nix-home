local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("Installing packer...")
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost bootstrap.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
    use({ 'nvim-tree/nvim-web-devicons' })
    use({ 'nvim-lua/plenary.nvim' })
    use({ "fatih/vim-go", run = ":GoUpdateBinaries", ft = { "go" } })
    use({ 'majutsushi/tagbar' })
    use({ 'tpope/vim-fugitive' })
    use({ 'tpope/vim-surround' })
    use({ 'tpope/vim-unimpaired' })
    use({ 'preservim/nerdtree' })
    use({ 'Xuyuanp/nerdtree-git-plugin' })
    use({ 'rust-lang/rust.vim' })
    use({ 'kana/vim-textobj-user' })
    use({ 'reedes/vim-textobj-quote' })
    use({ 'junegunn/vim-peekaboo' })
    use({ 'bufbuild/vim-buf' })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'saadparwaiz1/cmp_luasnip' })
    use({ 'L3MON4D3/LuaSnip' })
    use({ 'folke/tokyonight.nvim' })
    use({ 'ray-x/lsp_signature.nvim' })
    use({ 'rafamadriz/friendly-snippets' })
    use({ 'lspcontainers/lspcontainers.nvim' })
    use({ 'p00f/nvim-ts-rainbow' })
    use({ 'terrastruct/d2-vim'})
    use({ 'hashivim/vim-terraform'})
    use({ 'NoahTheDuke/vim-just'})


    use({
        'simrat39/rust-tools.nvim',
        config = function()
            require("rust-tools").setup({})
        end,
    })

    use({
        'ibhagwan/fzf-lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require'fzf-lua'.setup({
                grep = {
                    rg_opts="--column --line-number --no-heading --color=always --smart-case --hidden -g \"!.git/*\""
                },
            })
            vim.cmd[[
                command! -bang -nargs=* Rg lua require('fzf-lua').grep({search=<q-args>})
            ]]
        end,
    })

    use({
        'hrsh7th/nvim-cmp',
        config = function()
            require("plugins.cmp")
        end,
    })

    use({
        'neovim/nvim-lspconfig',
        config = function()
            require("plugins.lspconfig")
        end,
    })

    use({
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    })

    use({
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require("plugins.tstextobjects")
        end,
    })

    use({
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                go = {'golangcilint',},
                sh = {'shellcheck',},
                markdown = {'vale',},
                asciidoc = {'vale',},
                text = {'vale',},
                yaml = {'yamllint',},
            }
        end,
    })

    use({
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    })

    use({
        'folke/trouble.nvim',
        config = function()
            require("plugins.trouble")
        end,
        requires = "nvim-tree/nvim-web-devicons",
    })

    use({
        'nvim-telescope/telescope.nvim',
        config = function()
            require("plugins.telescope")
        end,
        requires = { {'nvim-lua/plenary.nvim'} }
    })

    use({
        'nvim-lualine/lualine.nvim',
        config = function()
            require("plugins.lualine")
        end,
    })

    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    })

    use({
        'windwp/nvim-autopairs',
        config = function()
            require("plugins.autopairs")
        end,
        requires = {
            {'nvim-treesitter/nvim-treesitter'},
            {'hrsh7th/nvim-cmp'},
        }
    })

    use({
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
        require("plugins.hop")
      end,
    })

  if packer_bootstrap then
    vim.notify("Installing plugins...")
    require("packer").sync()
  end
end)
