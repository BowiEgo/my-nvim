return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc", "cmake", "glsl" },
      highlight = { enable = true },
    },
  },
}