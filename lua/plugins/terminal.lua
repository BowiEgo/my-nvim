-- Check if a command exists on PATH
local function executable(cmd)
  return vim.fn.executable(cmd) == 1
end

-- OS-dependent shell selection with fallbacks
local function get_shell()
  if vim.fn.has("win32") == 1 then
    -- Windows: try pwsh → powershell → cmd
    if executable("pwsh") then
      return "pwsh"
    elseif executable("powershell") then
      return "powershell"
    else
      return "cmd"
    end
  end

  -- Unix-like (macOS / Linux / BSD)
  local shell = vim.fn.getenv("SHELL")
  if shell and vim.trim(shell) ~= "" and executable(shell) then
    return shell
  end

  -- Fallback chain for any Unix-like
  if executable("zsh") then
    return "zsh"
  elseif executable("bash") then
    return "bash"
  else
    return "sh"
  end
end

-- Set j+k to return to normal mode in terminal
local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "jk", "<C-\\><C-n>", opts)
  vim.keymap.set("t", "kj", "<C-\\><C-n>", opts)
end

-- Auto-apply keymaps when a toggleterm terminal opens
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    set_terminal_keymaps()
  end,
})

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      direction = "horizontal",
      shell = get_shell(),
      size = 15,
    },
  },
}
