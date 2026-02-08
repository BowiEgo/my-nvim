local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Annotation: This loads NvChad's internal LSP logic
      require "nvchad.configs.lspconfig"
      -- Annotation: This loads your personal clangd setup
      -- require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      trash = {
        cmd = "trash-put",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    config = function()
      require("toggleterm").setup({
        direction = "float",
        size = 60,
      })
    end,
  },
}

return plugins
