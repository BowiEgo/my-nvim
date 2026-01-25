return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- 隐藏根目录名，让界面更清爽
      hide_root_node = true,
      -- 更改默认组件符号
      default_component_configs = {
        indent = {
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true, -- 开启展开/收起箭头
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
      filesystem = {
        -- 开启跟随当前文件功能
        follow_current_file = {
          enabled = true, -- 开启跟随
          leave_dirs_open = false, -- 如果设置为 true，切换文件时不会自动收起其他目录
        },
        -- 建议同时开启此项：在打开文件树时，自动定位到当前文件
        use_libuv_file_watcher = true, 
      },
      window = {
        -- 移除窗口边框，配合 Edgy 达到一体化效果
        mappings = {
          ["<space>"] = "none", -- 禁用默认空格
        },
      },
    },
  },
}