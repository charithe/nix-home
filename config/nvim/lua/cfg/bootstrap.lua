local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "majutsushi/tagbar",
    "tpope/vim-fugitive",
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "preservim/nerdtree",
    "Xuyuanp/nerdtree-git-plugin",
    "kana/vim-textobj-user",
    "reedes/vim-textobj-quote",
    "junegunn/vim-peekaboo",
    "bufbuild/vim-buf",
    "ray-x/lsp_signature.nvim",
    "lspcontainers/lspcontainers.nvim",
    "p00f/nvim-ts-rainbow",
    "NoahTheDuke/vim-just",
    {
        "folke/tokyonight.nvim",
        lazy=false,
        priority=1000,
    },
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy=true,
    },
    {
        "fatih/vim-go",
        build=":GoUpdateBinaries",
    },
    {
        "terrastruct/d2-vim",
        lazy=true,
        ft={"d2"},
    },
    {
        "hashivim/vim-terraform",
        lazy=true,
        ft={"terraform"}
    },
    {
        "nvim-lua/plenary.nvim",
        lazy=true,
    },
    {
        "rust-lang/rust.vim",
        lazy=true,
        ft={"rust"},
    },
    {
        "simrat39/rust-tools.nvim",
        lazy=true,
        ft={"rust"},
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({
                grep = {
                    rg_opts="--column --line-number --no-heading --color=always --smart-case --hidden -g \"!.git/*\""
                },
            })
            vim.cmd[[
                command! -bang -nargs=* Rg lua require('fzf-lua').grep({search=<q-args>})
            ]]
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("plugins.cmp")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lspconfig")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            init = function()
                require("plugins.tstextobjects")
            end,
        },
        config = function()
            require("plugins.treesitter")
        end,
    },
    {
        "mfussenegger/nvim-lint",
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
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("plugins.trouble")
        end,
        dependencies = {"nvim-tree/nvim-web-devicons"},
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("plugins.telescope")
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.lualine")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("plugins.autopairs")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "hrsh7th/nvim-cmp",
        }
    },
    {
        "ellisonleao/glow.nvim",
        config = function()
            require('glow').setup()
        end,
    },
})



--[=====[
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
        'ellisonleao/glow.nvim',
        config = function()
            require('glow').setup()
        end,
    })


  if packer_bootstrap then
    vim.notify("Installing plugins...")
    require("packer").sync()
  end
end)
--]=====]
