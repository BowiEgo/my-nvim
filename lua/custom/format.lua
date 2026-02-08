require("conform").setup({
    event = { "BufWritePre" }, -- 自动执行的关键事件 (Before saving buffer)
    cmd = { "ConformInfo" },
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters = {
        ["clang-format"] = {
            prepend_args = { "--assume-filename=$FILENAME" },
        },
    },
})