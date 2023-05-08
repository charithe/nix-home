local function set_mappings()
  local opts = { noremap = true, silent = true }
  local mappings = {
    { "n", "<leader>d", [[<Cmd>bd<CR>]], opts }, -- close current buffer
    { "n", "<leader>c", [[<Cmd>cclose<CR>]], opts }, -- close quickfix list
    { "n", "<leader>h", [[<Cmd>split<CR>]], opts }, -- create horizontal split
    { "n", "<leader>v", [[<Cmd>vsplit<CR>]], opts }, -- create vertical split
    { "v", "<", [[<gv]], opts }, -- move code forward in visual mode
    { "v", ">", [[>gv]], opts }, -- move code backwards in visual mode
    { "n", "<leader>n", [[<Cmd>cn<CR>]], opts }, -- move to next item in quickfix list
    { "n", "<leader>p", [[<Cmd>cp<CR>]], opts }, -- move to prev item in quickfix list
  }

  for _, map in pairs(mappings) do
    vim.api.nvim_set_keymap(unpack(map))
  end
end

set_mappings()

-- globals
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

vim.g["go_gopls_enabled"] = 0
vim.g["fzf_layout"] = "{ 'window': 'enew' }"
vim.g["fzf_buffers_jump"] = 1
vim.g["fzf_preview_window"] = "down:50%"
vim.g["NERDTreeWinPos"] = "right"
vim.g["tagbar_position"] = "left"
vim.g["tagbar_compact"] = 1
vim.g["tagbar_autopreview"] = 0
vim.g["terraform_fmt_on_save"] = 1
vim.g["terraform_align"] = 1
vim.g["peekaboo_window"] = "split bo 30new"
vim.g["nightflyCursorColor"] = 1
vim.g["nightflyUndercurls"] = 1
vim.g["rustfmt_autosave"] = 1
vim.g["vista_sidebar_position"] = "vertical topleft"
vim.g["vista_stay_on_open"] = 0
vim.g["vista_executive_for"] = { go="nvim_lsp", rust="nvim_lsp" }

-- other options
local opt = vim.opt

opt.autoindent = true
opt.autoread = true
opt.backspace = "indent,eol,start"
opt.backupdir = vim.fn.stdpath("data") .. "/backup"
opt.clipboard = "unnamedplus"
opt.colorcolumn = "120"
opt.colorcolumn = "120"
opt.completeopt = { "menu", "menuone", "preview", "noselect" }
opt.directory = vim.fn.stdpath("data") .. "/swap"
opt.encoding = "utf-8"
opt.expandtab = true
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 2
opt.foldmethod = "expr"
opt.foldminlines = 15
opt.grepprg = "rg --vimgrep"
opt.hidden = true
opt.history = 500
opt.hlsearch = true
opt.incsearch = true
opt.laststatus= 2
opt.lazyredraw = true
opt.listchars= { tab = "→ ", space = "⋅", eol = "↲", nbsp = "␣" , trail = "•" , extends = "❯", precedes = "❮", }
opt.modeline = true
opt.mouse = "a"
opt.number = true
opt.ruler = true
opt.scrolloff = 3
opt.selectmode = "key"
opt.shiftwidth = 4
opt.showbreak = "↪ "
opt.showcmd = true
opt.showmode = true
opt.signcolumn = "yes"
opt.smartcase = true
opt.smarttab = true
opt.softtabstop = 4
opt.spelloptions = "camel"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.ttyfast = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true
opt.updatetime= 1000
opt.visualbell = true
opt.whichwrap = "<,>,h,l"
opt.wildignorecase = true
opt.wildmenu = true
opt.wildmode = "list:longest"

opt.fillchars:append("fold:┈")
opt.fillchars:append("vert:│")

vim.cmd[[
" colorscheme nightfly
colorscheme tokyonight
syntax on
filetype plugin indent on
" Lint
autocmd BufWritePost <buffer> lua require('lint').try_lint()

" Open Tagbar automatically
autocmd FileType go,rust,make TagbarOpen


" Open NERDTree automatically
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p

" Quit when NERDTree is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Set spacing for YAML files
" autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Set spell check for text file types
autocmd FileType asciidoc,markdown,md,rst,tex,text,go,rust setlocal spell spelllang=en_gb

" Use smart quotes in text files
augroup textobj_quote
  autocmd!
  autocmd FileType markdown call textobj#quote#init()
  autocmd FileType textile call textobj#quote#init()
  autocmd FileType text call textobj#quote#init({'educate': 0})
augroup end

augroup DragQuickfixWindowDown
    autocmd!
    autocmd FileType qf wincmd J
augroup end

" Strip trailing spaces
augroup TrimTrailingWhitespaces
    au!
    au BufWritePre * :lua trim_trailing_whitespaces()
augroup END

" Move to last cursor location
autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case --hidden -g "!.git/*" '.shellescape(<q-args>), 1,<bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('down:50%', '?'), <bang>0)

" Map j and k to gj/gk, but only when no count is given
" However, for larger jumps like 6j add the current position to the jump list
" so that you can use <c-o>/<c-i> to jump to the previous position
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Terraform
silent! autocmd! filetypedetect BufRead,BufNewFile *.tf
autocmd BufRead,BufNewFile *.hcl set filetype=hcl
autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl
autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
]]
