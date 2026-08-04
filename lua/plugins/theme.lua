return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- optional: latte, frappe, macchiato, mocha
      transparent_background = false,
      term_colors = true,
      integrations = {
        mini = true,
        native_lsp = {
          enabled = true,
        },
        edgy = true,
      },
    },
  },
}