local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

if vim.lsp.config then
  -- New 0.11+ style
  vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_markers = { ".git", "compile_commands.json", "xmake.lua" },
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
else
  -- Old style fallback
  local lspconfig = require "lspconfig"
  lspconfig.clangd.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end