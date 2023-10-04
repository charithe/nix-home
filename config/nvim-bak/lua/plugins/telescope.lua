local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  pickers = {
    buffers = {
        sort_mru = true,
        ignore_current_buffer = true,
    },
  },
})

telescope.load_extension("fzf")


local opts = { noremap = true }
local mappings = {
  { "n", "<leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], opts },
  { "n", "<leader>ff", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], opts },
  { "n", "<leader>fb", [[<Cmd>lua require("telescope.builtin").file_browser()<CR>]], opts },
  { "n", "<leader>s", [[<Cmd>lua require("telescope.builtin").grep_string()<CR>]], opts },
  { "n", "<leader>gr", [[<Cmd>lua require("telescope.builtin").lsp_references()<CR>]], opts },
  { "n", "<leader>gi", [[<Cmd>lua require("telescope.builtin").lsp_implementations()<CR>]], opts },
  { "n", "<leader>gd", [[<Cmd>lua require("telescope.builtin").lsp_definitions()<CR>]], opts },
  { "n", "<leader>td", [[<Cmd>lua require("telescope.builtin").lsp_type_definitions()<CR>]], opts },
  { "n", "<leader>ds", [[<Cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]], opts },
  { "n", "<C-space>", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], opts },
}


for _, map in pairs(mappings) do
  vim.api.nvim_set_keymap(unpack(map))
end
