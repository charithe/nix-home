return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
    },
    keys = {
      { "<leader>fg", "<cmd>Neotree reveal<CR>", desc = "Locate file in Neotree", remap = true },
    },
  },
}
