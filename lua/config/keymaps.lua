-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local function xmake_exec(command)
  vim.cmd("wa") -- save all buffers before running build commands
  -- use of TermExec for better terminal management
  vim.cmd(string.format('TermExec cmd="%s" direction=horizontal size=15', command))
end

vim.keymap.set("n", "<leader>xb", function() xmake_exec("xmake") end, { desc = "Xmake Build" })
vim.keymap.set("n", "<leader>xr", function() xmake_exec("xmake run") end, { desc = "Xmake Run" })
vim.keymap.set("n", "<leader>xc", function() xmake_exec("xmake config -m debug") end, { desc = "Xmake Config Debug" })

vim.keymap.set("n", "<leader>u1", function()
  if vim.api.nvim_get_commands({}).Neotree then
    vim.cmd("Neotree show")
  else
    -- if Neotree didn't load, try to trigger the default file explorer
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>e", true, true, true), "m", true)
  end

  -- open two bottom terminals
  -- termial#1 for btop or monitoring
  vim.cmd("1ToggleTerm direction=horizontal size=10 cmd=btop4win")
  -- termial#2 for daily input or build
  vim.cmd("2ToggleTerm direction=horizontal size=15")
end, { desc = "Bowiego Layout" })