return {
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            -- もとの Vim 設定を Lua に変換してそのまま反映
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 0
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_open_ip = ""
            vim.g.mkdp_browser = ""
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_browserfunc = ""
            vim.g.mkdp_markdown_css = ""
            vim.g.mkdp_highlight_css = ""
            vim.g.mkdp_port = "8890"
            vim.g.mkdp_page_title = "${name}"
            vim.g.mkdp_theme = "dark"

            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                maid = {},
                disable_sync_scroll = 0,
                sync_scroll_type = "middle",
            }
        end,
    },
}
