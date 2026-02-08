local map = vim.keymap.set
_G.xmake_term_chan = _G.xmake_term_chan or nil

local function xmake_run(command)
  local dir = vim.fn.expand("%:p:h")
  
  -- 1. 寻找标记的缓冲区
  local target_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.b[buf].is_xmake_term then
      target_buf = buf
      break
    end
  end

  -- 2. 处理窗口逻辑
  if target_buf then
    local win_id = vim.fn.bufwinid(target_buf)
    if win_id ~= -1 then
      vim.api.nvim_set_current_win(win_id)
    else
      vim.cmd("split | wincmd J | resize 15")
      vim.api.nvim_win_set_buf(0, target_buf)
    end
  else
    vim.cmd("split | wincmd J | enew | resize 15")
    target_buf = vim.api.nvim_get_current_buf()
    vim.b[target_buf].is_xmake_term = true
    vim.opt_local.buflisted = false
    vim.opt_local.bufhidden = "hide"
    
    -- 启动默认终端
    vim.fn.termopen(vim.o.shell, { cwd = dir })
    _G.xmake_term_chan = vim.b.terminal_job_id
  end

  -- 3. 构建并发送命令
  -- Annotation: Use \27 (Esc) + \1 (Home) + \11 (Delete to end) to clear line safely on Windows
  -- Or just send multiple Backspaces. But the simplest is often sending a raw newline first.
  vim.defer_fn(function()
    if _G.xmake_term_chan then
      -- 发送一个 Ctrl+C 确保杀掉之前可能卡住的任务，然后发送换行
      -- \3 是 Ctrl+C
      vim.api.nvim_chan_send(_G.xmake_term_chan, "\3\r\n")
      
      -- 构建命令：Windows 下 cmd.exe 使用 cd /d，PowerShell 只需要 cd
      local shell_name = vim.o.shell:lower()
      local full_cmd
      
      if shell_name:match("powershell") or shell_name:match("pwsh") then
        full_cmd = string.format('cd "%s"; %s\r\n', dir, command)
      else
        full_cmd = string.format('cd /d "%s" && %s\r\n', dir, command)
      end
      
      vim.api.nvim_chan_send(_G.xmake_term_chan, full_cmd)
      vim.cmd("normal! G")
      vim.cmd("startinsert")
    end
  end, 100)
end

-- Annotation: Xmake keybindings
map("n", "<leader>pb", function() xmake_run("xmake build") end, { desc = "Xmake build" })
map("n", "<leader>pr", function() xmake_run("xmake run") end, { desc = "Xmake run" })
map("n", "<leader>pc", function() xmake_run("xmake config -p linux -a x86_64") end, { desc = "Xmake config" })
map("n", "<leader>pg", function() xmake_run("xmake project -k compile_commands") end, { desc = "Xmake gen compile_commands" })

-- Annotation: If you want these to show up in which-key as a group
local status_wk, wk = pcall(require, "which-key")
if status_wk then
  wk.add({
    { "<leader>p", group = "project" }, -- New which-key v3 syntax
  })
end