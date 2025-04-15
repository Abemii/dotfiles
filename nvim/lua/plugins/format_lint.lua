return {
    -- Formatter (conform.nvim)
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.setup({
                -- フォーマッタをファイルタイプごとに定義
                formatters_by_ft = {
                    python = { "ruff_format", "isort" },
                    sh = { "shfmt" },
                    cpp = { "clang_format" },
                    c = { "clang_format" },
                    h = { "clang_format" },
                    hpp = { "clang_format" },
                    lua = { "stylua" },
                },
                -- format_on_save を無効nvm_install_dirにする
                format_on_save = false,
                formatters = {
                    auto = {
                        lsp_fallback = true,
                    },
                },
            })

            vim.keymap.set("n", "<leader>f", function()
                conform.format({ async = true })
            end, { desc = "Format buffer with conform" })

            vim.keymap.set("n", "<leader>F", function()
                conform.format({ async = true, range = nil })
            end, { desc = "Force format full buffer" })
        end,
    },

    -- Linter (nvim-lint)
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost", "InsertLeave" },
        config = function()
            local lint = require("lint")

            local linters_by_ft = {}

            if vim.fn.executable("ruff") == 1 then
                linters_by_ft.python = { "ruff" }
            end

            lint.linters_by_ft = linters_by_ft

            -- 自動実行
            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
