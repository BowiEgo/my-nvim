return {
  {
    "Mythos-404/xmake.nvim",
    enabled = true,
    lazy = true, 
    keys = {
      { "<leader>xb", "<cmd>split | term xmake build<cr>", desc = "Xmake Build" },
      { "<leader>xr", "<cmd>split | term xmake run<cr>", desc = "Xmake Run" },
      { "<leader>xc", "<cmd>split | term xmake f -p windows -a x64 -m debug<cr>", desc = "Xmake Configure" },
      { "<leader>xp", "<cmd>split | term xmake project -k compile_commands<cr>", desc = "Generate LSP JSON" },
    }
  }
}