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

            -- ステータスラインに現在の関数名を表示（vistaの NearestMethodOrFunction 相当）
            vim.o.statusline = vim.o.statusline .. "%{%v:lua.require'aerial'.get_location()%}"

            -- 自動で aerial を attach（vista#RunForNearestMethodOrFunction 相当）
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local ok, aerial = pcall(require, "aerial")
                    if ok and aerial.attach then
                      aerial.attach(args.buf)
                    end
                end,
            })

            -- キーマップ（Vista と似た操作）
            vim.keymap.set("n", "<C-f><C-v>", "<cmd>AerialToggle<CR>", { silent = true })
            vim.keymap.set("n", "<C-f><C-s>", "<cmd>AerialNavToggle<CR>", { silent = true })
        end,
    },
}
