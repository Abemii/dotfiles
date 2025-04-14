return {
    {
        "stevearc/aerial.nvim",
        opts = {
            layout = {
                min_width = 30,
                default_direction = "prefer_left",
            },
            attach_mode = "window",                   -- bufferごとに表示
            backends = { "lsp", "treesitter", "markdown" }, -- vista_default_executive 相当
            show_guides = true,
            icons = {
                -- 例: vista で設定していたものに近いアイコンを定義
                Function = "", -- or "\uf794"
                Variable = "", -- or "\uf71b"
                -- 他にも適宜追加可能
            },
        },
        config = function(_, opts)
            require("aerial").setup(opts)

            -- 自動で aerial を attach（vista#RunForNearestMethodOrFunction 相当）
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local ok, aerial = pcall(require, "aerial")
                    if ok and aerial.attach then
                      aerial.attach(args.buf)
                    end
                end,
            })

            vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
        end,
    },
}
