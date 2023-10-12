return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = false,
      },
    })
  end,
  keys = {
    { "<leader>lt", "<cmd>Lspsaga toggle_term<CR>", desc = "Toggle term" },
    { "<leader>lsk", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover docs" },
    { "<leader>lsf", "<cmd>Lspsaga finder<CR>", desc = "Finder" },
    { "<leader>lsd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
    { "<leader>lst", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek type definition" },
    { "<leader>lss", "<cmd>Lspsaga outline<CR>", desc = "Outline" },
    { "<leader>lsi", "<cmd>Lspsaga incoming_calls<CR>", desc = "Incoming calls" },
    { "<leader>lso", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Outgoing calls" },
    { "<leader>lsc", "<cmd>Lspsaga code_action<CR>", desc = "Outgoing calls" },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
