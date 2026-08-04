return {
  -- 1. 通过 Mason 安装 biome
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
      },
    },
  },

  -- 2. 配置 Biome LSP（仅诊断）
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
      },
    },
  },

  -- 3. conform.nvim 使用 biome-check（格式化 + lint + import 排序）
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { "biome-check" },
        javascriptreact = { "biome-check" },
        typescript = { "biome-check" },
        typescriptreact = { "biome-check" },
        json = { "biome-check" },
        jsonc = { "biome-check" },
        css = { "biome-check" },
        scss = { "biome-check" },
      },
      formatters = {
        ["biome-check"] = {
          require_cwd = true, -- 只在项目有 biome.json 时激活
        },
      },
    },
  },

  -- 4. nvim-lint 已由 biome-check 覆盖，无需单独配置 biomejs
  -- （如果仍需独立 lint，取消下面的注释）
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {
  --       javascript = { "biomejs" },
  --       typescript = { "biomejs" },
  --       -- ...
  --     },
  --   },
  -- },

  -- 5. Treesitter 语法支持
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "javascript",
        "typescript",
        "tsx",
        "json",
        "css",
        "scss",
      })
    end,
  },
}
