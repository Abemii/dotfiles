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
                    markdown = { "prettier" },
                    lua = { "stylua" },
                    sh = { "shfmt" },
                    json = { "jq" },
                },
                -- format_on_save を無効にする
                format_on_save = false,
            })

            -- 明示的に実行するキー設定
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

            lint.linters_by_ft = {
                python = { "ruff" },
                markdown = { "textlint" },
                json = { "jsonlint" },
                sh = { "shellcheck" },
            }

            -- 自動実行
            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
