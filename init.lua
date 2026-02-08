vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "custom.plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- ---------------------------------------------------------
-- [FORCE LOAD CUSTOM] 强行加载自定义逻辑
-- ---------------------------------------------------------
local function force_load_custom()
  -- 1. 加载 custom/init.lua
  local status_init, _ = pcall(require, "custom")
  if not status_init then
    print "Error: Could not find lua/custom/init.lua"
  end

  -- 2. 加载主题
  pcall(function()
    require("base46").load_theme "ashes"
  end)
end

-- 延迟一丁点时间执行，确保插件已就绪
vim.schedule(force_load_custom)