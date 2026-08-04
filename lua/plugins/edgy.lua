return {
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
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