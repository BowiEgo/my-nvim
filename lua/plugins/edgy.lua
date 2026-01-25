return {
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.left = opts.left or {}
      table.insert(opts.left, {
        ft = "neo-tree",
        title = "Neo-Tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        size = { width = 50 },
      })

      opts.bottom = opts.bottom or {}
      table.insert(opts.bottom, {
        ft = "toggleterm",
        title = "Terminal",
        size = { height = 0.3 },
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      })

      opts.options = opts.options or {}
      opts.options.left = { size = 30 }
    end,
  },
}